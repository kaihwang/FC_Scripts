#!/bin/bash

# script to preprocess the human connectome data.
# here we will take the minimally preprocessed connectome data, and run it through our typical AFNI pipeline.


WD='/home/despoB/connectome-thalamus'
RAW='/home/despoB/connectome-raw'

for s in 414229; do
	
	if [ ! -d "${WD}/connectome/${s}/" ]; then
		mkdir ${WD}/connectome/${s}/
	fi
	
	if [ ! -d "${WD}/connectome/${s}/MNINonLinear/" ]; then
		mkdir ${WD}/connectome/${s}/MNINonLinear/
	fi
	
	cd ${WD}/connectome/${s}/MNINonLinear/
	
	#copy structural files and segmentations
	3dcopy ${RAW}/${s}/MNINonLinear/aparc+aseg.nii.gz ${WD}/connectome/${s}/MNINonLinear/aseg
	3drefit -view tlrc ${WD}/connectome/${s}/MNINonLinear/aseg+orig
	
	# bunc of T1s no idea what is what at this point...
	ln -s ${RAW}/${s}/MNINonLinear/T1w_restore.nii.gz ${WD}/connectome/${s}/MNINonLinear/T1w_restore.nii.gz
	ln -s ${RAW}/${s}/MNINonLinear/T1w.nii.gz ${WD}/connectome/${s}/MNINonLinear/T1w.nii.gz
	ln -s ${RAW}/${s}/MNINonLinear/T1w_restore.2.nii.gz ${WD}/connectome/${s}/MNINonLinear/T1w_restore.2.nii.gz
	ln -s ${RAW}/${s}/MNINonLinear/T1w_restore_brain.nii.gz ${WD}/connectome/${s}/MNINonLinear/T1w_restore_brain.nii.gz
	
	# create temp output folder
	mkdir /tmp/${s}

	for run in rfMRI_REST1_LR  rfMRI_REST1_RL rfMRI_REST2_LR  rfMRI_REST2_RL  ; do #rfMRI_REST2_LR  rfMRI_REST2_RL will be used for validation
		
		#create symbolic link of functional data and regressors for motion data
		ln -s ${RAW}/${s}/MNINonLinear/Results/${run}/${run}.nii.gz ${WD}/connectome/${s}/MNINonLinear/${run}.nii.gz
		cp ${RAW}/${s}/MNINonLinear/Results/${run}/Movement_Regressors_dt.txt ${WD}/connectome/${s}/MNINonLinear/${run}_mopar.1D
		
		# Per Julie's suggestion. Do the calculations in /tmp
		mkdir /tmp/${s}/${run}

		cd /tmp/${s}/${run}

		3dcopy ${WD}/connectome/${s}/MNINonLinear/${run}.nii.gz /tmp/${s}/${run}/${run}_input
		cp ${WD}/connectome/${s}/MNINonLinear/aseg+tlrc* /tmp/${s}/${run}/
		cp ${WD}/connectome/${s}/MNINonLinear/${run}_mopar.1D /tmp/${s}/${run}/

		@ANATICOR \
		-ts /tmp/${s}/${run}/${run}_input+tlrc \
		-polort 3 \
		-aseg /tmp/${s}/${run}/aseg+tlrc \
		-motion /tmp/${s}/${run}/${run}_mopar.1D \
		-prefix ${run}_reg \
		-view +tlrc
		
		3dBandpass \
		-nodetrend -automask \
		-blur 5 -band 0.009 0.08 \
		-prefix ${WD}/connectome/${s}/MNINonLinear/${run}_reg_bp.nii.gz \
		-input /tmp/${s}/${run}/${run}_reg+tlrc 
				
		#rm ${WD}/connectome/${s}/MNINonLinear/${run}_reg+tlrc* 
		#rm ${WD}/connectome/${s}/MNINonLinear/${run}_input*
		rm -rf /tmp/${s}/${run}


	done
	rm -rf /tmp/${s}/
done
