#!/bin/bash

# script to preprocess the human connectome data.
# here we will take the minimally preprocessed connectome data, and run it through our typical AFNI pipeline.


WD='/home/despoB/connectome-thalamus'
RAW='/home/despoB/connectome-raw'

for s in 100307; do
	
	mkdir ${WD}/connectome/${s}/
	mkdir ${WD}/connectome/${s}/MNINonLinear/
	cd {WD}/connectome/${s}/MNINonLinear/
	
	#copy structural files and segmentations
	3dcopy ${RAW}/${s}/MNINonLinear/aparc+aseg.nii.gz {WD}/connectome/${s}/MNINonLinear/aseg
	3drefit -view tlrc {WD}/connectome/${s}/MNINonLinear/aseg+orig
	
	# bunc of T1s no idea what is what at this point...
	ln -s ${RAW}/${s}/MNINonLinear/T1w_restore.nii.gz {WD}/connectome/${s}/MNINonLinear/T1w_restore.nii.gz
	ln -s ${RAW}/${s}/MNINonLinear/T1w.nii.gz {WD}/connectome/${s}/MNINonLinear/T1w.nii.gz
	ln -s ${RAW}/${s}/MNINonLinear/T1w_restore.2.nii.gz {WD}/connectome/${s}/MNINonLinear/T1w_restore.2.nii.gz
	ln -s ${RAW}/${s}/MNINonLinear/T1w_restore_brain.nii.gz {WD}/connectome/${s}/MNINonLinear/T1w_restore_brain.nii.gz
	
	for run in rfMRI_REST1_LR  rfMRI_REST1_RL rfMRI_REST2_LR  rfMRI_REST2_RL  ; do #rfMRI_REST2_LR  rfMRI_REST2_RL will be used for validation
		
		#create symbolic link of functional data and regressors for motion data
		ln -s ${RAW}/${s}/MNINonLinear/Results/${run}/${run}.nii.gz {WD}/connectome/${s}/MNINonLinear/${run}.nii.gz
		cp ${WD}/${s}/MNINonLinear/Results/${run}/Movement_Regressors_dt.txt ${WD}/connectome/${s}/MNINonLinear/${run}_mopar.1D
		
		#remove previous version
		#rm ${WD}/${s}/MNINonLinear/Results/${run}/${run}_input*
		#rm __*
		#rm ${WD}/${s}/MNINonLinear/Results/${run}/anat*
		#rm ${WD}/${s}/MNINonLinear/Results/${run}/aseg*
		
		3dcopy {WD}/connectome/${s}/MNINonLinear/${run}.nii.gz ${WD}/connectome/${s}/MNINonLinear/${run}_input
		
		@ANATICOR \
		-ts ${WD}/connectome/${s}/MNINonLinear/${run}_input \
		-polort 3 \
		-aseg {WD}/connectome/${s}/MNINonLinear/aseg+tlrc \
		-motion ${WD}/connectome/${s}/MNINonLinear/${run}_mopar.1D \
		-prefix  ${WD}/connectome/${s}/MNINonLinear/${run}_reg \
		-view +tlrc
		
		3dBandpass \
		-nodetrend -automask \
		-blur 5 -band 0.009 0.08 \
		-prefix ${WD}/connectome/${s}/MNINonLinear/${run}_reg_bp.nii.gz \
		-input ${WD}/connectome/${s}/MNINonLinear/${run}_reg+tlrc 
				
		rm ${WD}/connectome/${s}/MNINonLinear/${run}_reg+tlrc* 
		rm ${WD}/connectome/${s}/MNINonLinear/${run}_input*
		
	done

done