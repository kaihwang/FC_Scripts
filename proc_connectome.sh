#!/bin/bash

# script to preprocess the human connectome data.
# here we will take the minimally preprocessed connectome data, and run it through our typical AFNI pipeline.


WD='/home/despo/kaihwang/Rest/Connectome'

for s in 100307; do

	for run in rfMRI_REST1_LR  rfMRI_REST1_RL  ; do #rfMRI_REST2_LR  rfMRI_REST2_RL will be used for validation
	
		#rm -rf ${WD}/${s}/MNINonLinear/Results/${run}/Preproc/
		cd ${WD}/${s}/MNINonLinear/Results/${run}/
				
		rm ${WD}/${s}/MNINonLinear/Results/${run}/${run}_input*
		#rm ${WD}/${s}/MNINonLinear/Results/${run}/anat*
		rm ${WD}/${s}/MNINonLinear/Results/${run}/aseg*
		
		3dcopy ${WD}/${s}/MNINonLinear/Results/${run}/${run}.nii.gz ${WD}/${s}/MNINonLinear/Results/${run}/${run}_input
		#3dcopy /usr/local/fsl-5.0.6/data/standard/MNI152lin_T1_1mm.nii.gz ${WD}/${s}/MNINonLinear/Results/${run}/anat
		#3drefit -view orig ${WD}/${s}/MNINonLinear/Results/${run}/anat+tlrc
		3dcopy ${WD}/${s}/MNINonLinear/aparc+aseg.nii.gz ${WD}/${s}/MNINonLinear/Results/${run}/aseg
		3drefit -view tlrc ${WD}/${s}/MNINonLinear/Results/${run}/aseg+orig
		cp ${WD}/${s}/MNINonLinear/Results/${run}/Movement_Regressors_dt.txt ${WD}/${s}/MNINonLinear/Results/${run}/mopar.1D
		
		@ANATICOR \
		-ts ${run}_input+tlrc \
		-polort 3 \
		-aseg aseg+tlrc \
		-motion mopar.1D \
		-prefix ${run}_reg \
		-view +tlrc
		#-echo
		
		3dBandpass \
		-nodetrend -automask \
		-blur 5 -band 0.009 0.08 \
		-prefix ${run}_reg_bp.nii.gz \
		-input ${run}_reg+tlrc 
		
		#afni_restproc.py \
		#-epi ${WD}/${s}/MNINonLinear/Results/${run}/${run}_input+tlrc \
		#-anat ${WD}/${s}/MNINonLinear/Results/${run}/anat+tlrc \
		#-prefix ${WD}/${s}/MNINonLinear/Results/${run}/${s}_${run}.nii.gz \
		#-dest ${WD}/${s}/MNINonLinear/Results/${run}/Preproc/ \
		#-align off \
		#-aseg ${WD}/${s}/MNINonLinear/Results/${run}/aseg+tlrc \
		#-regressor ${WD}/${s}/MNINonLinear/Results/${run}/Movement_Regressors.txt \
		#-globalnorm \
		#-smoothrad 5 \
		#-despike off \
		#-bandpass \
		#-bpassregs \
		#-script cmmd \
		#-trcut 0 \
		#-tsnr 
		
		rm ${WD}/${s}/MNINonLinear/Results/${run}/${run}_input*
		#rm ${WD}/${s}/MNINonLinear/Results/${run}/${run}_reg+tlrc*
		
		#rm ${WD}/${s}/MNINonLinear/Results/${run}/anat*
	done

done