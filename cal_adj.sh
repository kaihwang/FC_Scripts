#!/bin/bash
# script to create adj matrices


WD='/home/despoB/connectome-thalamus/NKI'

cd ${WD}


for s in 0102826_session_1; do

	cd ${WD}/${s}/MNINonLinear

	for run in _mx_1400 _mx_645 _std_2500; do

		#Crotical ROIs + Thalamsu (lobe), partial corr
		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Cortex_plus_thalamus_ROIs.nii.gz \
		-part_corr \
		-prefix Adj_cortex_thalamus_${run}_par

		#Crotical ROIs + Thalamsu (lobe)
		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Cortex_plus_thalamus_ROIs.nii.gz \
		-prefix Adj_cortex_thalamus_${run}


		#craddockROIs
		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Craddock_300_cortical.nii.gz \
		-prefix Adj_Craddock_300_${run}

		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Craddock_900_cortical.nii.gz \
		-prefix Adj_Craddock_900_${run}


		#craddockROIs+thalamus
		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Craddock_300_plus_thalamus_ROIs.nii.gz \
		-prefix Adj_Craddock_300_thalamus_${run}

		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Craddock_900_plus_thalamus_ROIs.nii.gz \
		-prefix Adj_Craddock_900_thalamus_${run}

		#craddockROIs+thalamus, partial corr
		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Craddock_300_plus_thalamus_ROIs.nii.gz \
		-part_corr \
		-prefix Adj_Craddock_300_thalamus_${run}_par

		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/Craddock_900_plus_thalamus_ROIs.nii.gz \
		-part_corr \
		-prefix Adj_Craddock_900_thalamus_${run}_par


	done	
	


done