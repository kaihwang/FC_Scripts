#!/bin/bash
# script to create adj matrices


WD='/home/despoB/connectome-thalamus/NKI'

cd ${WD}


for s in 0102826_session_1; do

	cd ${WD}/${s}/MNINonLinear

	for run in _mx_1400 _mx_645 _std_2500; do

		#Crotical ROIs + Thalamsu (lobe), partial corr
		# 3dNetCorr \
		# -inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		# -in_rois /home/despoB/connectome-thalamus/ROIs/Cortex_plus_thalamus_ROIs.nii.gz \
		# -part_corr \
		# -prefix Adj_cortex_thalamus_${run}_par


		for roi in Cortex_plus_thalamus_ROIs Craddock_300_plus_thalamus_ROIs Craddock_900_plus_thalamus_ROIs; do

			3dNetCorr \
			-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}_ncsreg.nii.gz \
			-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
			-prefix Adj_${roi}_${run}_ncsreg

			num=$(expr $(wc -l Adj_${roi}_${run}_ncsreg_000.netcc | awk '{print $1}') - 6)
			tail -n $num Adj_${roi}_${run}_ncsreg_000.netcc > /home/despoB/connectome-thalamus/AdjMatrices/NKI_${s}_${roi}_${run}_ncsreg_corrmat

		done


		for roi in Cortex_plus_thalamus_ROIs Craddock_300_cortical Craddock_900_cortical Craddock_300_plus_thalamus_ROIs Craddock_900_plus_thalamus_ROIs; do

			3dNetCorr \
			-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
			-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
			-prefix Adj_${roi}_${run}

			num=$(expr $(wc -l Adj_${roi}_${run}_000.netcc | awk '{print $1}') - 6)
			tail -n $num Adj_${roi}_${run}_000.netcc > /home/despoB/connectome-thalamus/AdjMatrices/NKI_${s}_${roi}_${run}_corrmat

		done
	done	

	rm *netcc
	rm *dset
done