#!/bin/bash
# script to create adj matrices


WD='/home/despoB/connectome-thalamus/MGH'

cd ${WD}


for s in Sub0001_Ses1; do

	mkdir /tmp/KH_${s}/
	cd ${WD}/${s}/MNINonLinear

	if [ -e ${WD}/${s}/MNINonLinear/rfMRI_REST2.nii.gz ]; then
		3dTcat -prefix rfMRI_REST.nii.gz rfMRI_REST1.nii.gz rfMRI_REST2.nii.gz
		3dTcat -prefix rfMRI_REST_ncsreg.nii.gz rfMRI_REST1_ncsreg.nii.gz rfMRI_REST2_ncsreg.nii.gz
	fi

	if [ -e ${WD}/${s}/MNINonLinear/rfMRI_REST_ncsreg.nii.gz ]; then
		#
		#Cortex_plus_thalamus_ROIs
		#Cortical_CI_plus_thalamus
		#Craddock_300_plus_thalamus_ROIs Craddock_900_plus_thalamus_ROIs
		for roi in Cortical_CI_plus_thalamus; do

			3dNetCorr \
			-inset ${WD}/${s}/MNINonLinear/rfMRI_REST_ncsreg.nii.gz \
			-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
			-prefix /tmp/KH_${s}/Adj_${roi}_ncsreg

			num=$(expr $(wc -l /tmp/KH_${s}/Adj_${roi}_ncsreg_000.netcc | awk '{print $1}') - 6)
			tail -n $num /tmp/KH_${s}/Adj_${roi}_ncsreg_000.netcc > /tmp/KH_${s}/MGH_${s}_${roi}_ncsreg_corrmat
			mv /tmp/KH_${s}/MGH_${s}_${roi}_ncsreg_corrmat /home/despoB/connectome-thalamus/AdjMatrices/
		done
	fi

	# if [ -e ${WD}/${s}/MNINonLinear/rfMRI_REST.nii.gz ]; then
	# 	for roi in Craddock_300_cortical Craddock_900_cortical; do

	# 		3dNetCorr \
	# 		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST.nii.gz \
	# 		-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
	# 		-prefix /tmp/KH_${s}/Adj_${roi}

	# 		num=$(expr $(wc -l /tmp/KH_${s}/Adj_${roi}_000.netcc | awk '{print $1}') - 6)
	# 		tail -n $num /tmp/KH_${s}/Adj_${roi}_000.netcc > /tmp/KH_${s}/MGH_${s}_${roi}_corrmat
	# 		mv /tmp/KH_${s}/MGH_${s}_${roi}_corrmat /home/despoB/connectome-thalamus/AdjMatrices/ 
	# 	done
	# fi

	rm -rf /tmp/KH_${s}/
done