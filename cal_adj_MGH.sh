#!/bin/bash
# script to create adj matrices


WD='/home/despoB/connectome-thalamus/MGH'

cd ${WD}


for s in Sub0001_Ses1; do

	cd ${WD}/${s}/MNINonLinear

	if [ -e ${WD}/${s}/MNINonLinear/rfMRI_REST2.nii.gz ]; then
		3dTcat -prefix rfMRI_REST.nii.gz rfMRI_REST1.nii.gz rfMRI_REST2.nii.gz
		3dTcat -prefix rfMRI_REST_ncsreg.nii.gz rfMRI_REST1_ncsreg.nii.gz rfMRI_REST2_ncsreg.nii.gz
	fi

	if [ -e ${WD}/${s}/MNINonLinear/rfMRI_REST_ncsreg.nii.gz ]; then
		for roi in Cortex_plus_thalamus_ROIs Craddock_300_plus_thalamus_ROIs Craddock_900_plus_thalamus_ROIs; do

			3dNetCorr \
			-inset ${WD}/${s}/MNINonLinear/rfMRI_REST_ncsreg.nii.gz \
			-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
			-prefix Adj_${roi}_ncsreg

			num=$(expr $(wc -l Adj_${roi}_ncsreg_000.netcc | awk '{print $1}') - 6)
			tail -n $num Adj_${roi}_ncsreg_000.netcc > /home/despoB/connectome-thalamus/AdjMatrices/MGH_${s}_${roi}_ncsreg_corrmat

		done
	fi

	if [ -e ${WD}/${s}/MNINonLinear/rfMRI_REST.nii.gz ]; then
		for roi in Cortex_plus_thalamus_ROIs Craddock_300_cortical Craddock_900_cortical Craddock_300_plus_thalamus_ROIs Craddock_900_plus_thalamus_ROIs; do

			3dNetCorr \
			-inset ${WD}/${s}/MNINonLinear/rfMRI_REST.nii.gz \
			-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
			-prefix Adj_${roi}

			num=$(expr $(wc -l Adj_${roi}_000.netcc | awk '{print $1}') - 6)
			tail -n $num Adj_${roi}_000.netcc > /home/despoB/connectome-thalamus/AdjMatrices/MGH_${s}_${roi}_corrmat

		done
	fi

	rm *netcc
	rm *dset
done