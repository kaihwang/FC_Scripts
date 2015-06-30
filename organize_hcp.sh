#!/bin/bash

#create sym link for the HCP "FIX" dataset

WD='/home/despoB/connectome-thalamus/connectome'
Source='/home/despoB/connectome-raw'

for s in $(cat ${WD}/list_of_complete_subjects); do

	#create sym link
	for session in rfMRI_REST1_LR rfMRI_REST1_RL rfMRI_REST2_LR rfMRI_REST2_RL; do
		ln -s ${Source}/${s}/MNINonLinear/Results/${session}/${session}_hp2000_clean.nii.gz \
		${WD}/${s}/MNINonLinear/${session}_hp2000_clean.nii.gz
	done
	ln -s ${Source}/${s}/MNINonLinear/brainmask_fs.nii.gz ${WD}/${s}/MNINonLinear/brainmask.nii.gz


done