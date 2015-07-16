#!/bin/bash

#create to preproc the HCP "FIX" dataset

WD='/home/despoB/connectome-thalamus/connectome'

for s in 100307; do
	3dresample -inset ${WD}/${s}/MNINonLinear/brainmask.nii.gz \
	-master ${WD}/${s}/MNINonLinear/rfMRI_REST1_LR_hp2000_clean.nii.gz \
	-prefix ${WD}/${s}/MNINonLinear/brainmask_ds.nii.gz

	#extract signal
	for session in rfMRI_REST1_LR rfMRI_REST1_RL rfMRI_REST2_LR rfMRI_REST2_RL; do
		3dmaskave -mask ${WD}/${s}/MNINonLinear/brainmask_ds.nii.gz -quiet \
		${WD}/${s}/MNINonLinear/${session}_hp2000_clean.nii.gz > ${WD}/${s}/MNINonLinear/${session}_WBS.1D
	
		3dTproject -input ${WD}/${s}/MNINonLinear/${session}_hp2000_clean.nii.gz \
		-prefix ${WD}/${s}/MNINonLinear/${session}_hp2000_clean_wbsreg.nii.gz \
		-ort ${WD}/${s}/MNINonLinear/${session}_WBS.1D \
		-passband 0.009 0.08 \
		-automask


	done
done