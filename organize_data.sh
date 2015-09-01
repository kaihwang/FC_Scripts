#!/bin/bash

#create sym link for the HCP "FIX" dataset
WD='/home/despoB/connectome-thalamus/connectome'
Source='/home/despoB/connectome-raw'

for s in $(cat ${WD}/list_of_complete_subjects); do

	#create sym link
	for session in rfMRI_REST1_LR rfMRI_REST1_RL rfMRI_REST2_LR rfMRI_REST2_RL; do
	
		if [ ! -e ${WD}/${s}/MNINonLinear/${session}_hp2000_clean.nii.gz ]; then
			ln -s ${Source}/${s}/MNINonLinear/Results/${session}/${session}_hp2000_clean.nii.gz \
			${WD}/${s}/MNINonLinear/${session}_hp2000_clean.nii.gz
		fi
	done

	if [ ! -e ${WD}/${s}/MNINonLinear/brainmask.nii.gz ]; then
		ln -s ${Source}/${s}/MNINonLinear/brainmask_fs.nii.gz ${WD}/${s}/MNINonLinear/brainmask.nii.gz
	fi

done



#create sym link for the MGH
WD='/home/despoB/connectome-thalamus/MGH'
Source='/home/despoB/harvard_gsp/preprocessed/pipeline_comp_cor_and_standard'

cd $Source
for s in $(ls -d Sub*); do

	if [ ! -d ${WD}/${s}/ ]; then
		mkdir ${WD}/${s}/
	fi

	if [ ! -d ${WD}/${s}/MNINonLinear ]; then
		mkdir ${WD}/${s}/MNINonLinear
	fi


	cd ${Source}/${s}/functional_mni/
	r=1
	for run in $(ls -d *); do
		if [ ! -e ${WD}/${s}/MNINonLinear/rfMRI_REST${r}.nii.gz ]; then
			ln -s ${Source}/${s}/functional_mni/${run}/_csf_threshold_0.96/_gm_threshold_0.7/_wm_threshold_0.96/_compcor_ncomponents_5_selector_pc10.linear1.wm0.global0.motion1.quadratic1.gm0.compcor1.csf0/_bandpass_freqs_0.009.0.08/bandpassed_demeaned_filtered_antswarp.nii.gz ${WD}/${s}/MNINonLinear/rfMRI_REST${r}.nii.gz
		fi

		cp ${Source}/${s}//movement_parameters/${run}/fristons_twenty_four.1D ${WD}/${s}/MNINonLinear/rfMRI_REST${r}_motion_24.1D 

		r=$(($r+1))
	done
done

#create NKI data link
WD='/home/despoB/connectome-thalamus/NKI'
Source='/home/despoB/mb3152/data/nki_data/preprocessed/pipeline_comp_cor_and_standard'

cd $Source
for s in $(ls -d 0*); do

	if [ ! -d ${WD}/${s}/ ]; then
		mkdir ${WD}/${s}/
	fi

	if [ ! -d ${WD}/${s}/MNINonLinear ]; then
		mkdir ${WD}/${s}/MNINonLinear
	fi


	cd ${Source}/${s}/functional_mni/
	r=1
	for run in _mx_1400 _mx_645 _std_2500; do

		if [ ! -e ${WD}/${s}/MNINonLinear/rfMRI_REST${r}.nii.gz ]; then
			ln -s /${Source}/${s}/functional_mni/_scan_RfMRI${run}_rest/_csf_threshold_0.96/_gm_threshold_0.7/_wm_threshold_0.96/_compcor_ncomponents_5_selector_pc10.linear1.wm0.global0.motion1.quadratic1.gm0.compcor1.csf0/_bandpass_freqs_0.009.0.08/bandpassed_demeaned_filtered_antswarp.nii.gz ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz
		fi

		cp ${Source}/${s}//movement_parameters/_scan_RfMRI${run}_rest/fristons_twenty_four.1D ${WD}/${s}/MNINonLinear/rfMRI_REST${run}_motion_24.1D 

	done
done


