#!/bin/bash

# register and align lesion masks to MNI space.

#subjects= 128 162 163 168 176 b116 b117 b120 b121 b122 b138 b143 b144 b153
WD='/home/despoB/kaihwang/Rest/Lesion_Masks'
standard='/home/despoB/kaihwang/standard/mni_icbm152_nlin_asym_09c'

for s in 128; do

	cd ${WD}
	#bet ${s}-T1.nii.gz ${s}-brain.nii.gz -R -S -B -f 0.05 -g -0.3
	3dSkullStrip -input ${s}-T1.nii.gz -prefix ${s}-brain.nii.gz

	flirt -ref ${standard}/mni_icbm152_t1_tal_nlin_asym_09c_brain.nii \
	-in ${s}-brain.nii.gz -omat ${s}_anat2mni_affine_trans.mat

	fnirt --in=${s}-T1.nii.gz \
	--aff=${s}_anat2mni_affine_trans.mat \
	--cout=${s}_anat2mni_nonlinear_trans \
	--config=T1_2_MNI152_2mm
	
	applywarp --ref=${standard}/mni_icbm152_t1_tal_nlin_asym_09c_brain.nii \
	--in=${s}-T1.nii.gz \
	--warp=${s}_anat2mni_nonlinear_trans --out=${s}_mni

	3dcopy LY-${s}-T1+orig ${s}_native_lesion_mask.nii.gz

	applywarp --ref=${standard}/mni_icbm152_t1_tal_nlin_asym_09c_brain.nii \
	--in=${s}_native_lesion_mask.nii.gz \
	--warp=${s}_anat2mni_nonlinear_trans \
	--out=${s}_mni_lesion_mask.nii.gz --interp=nn
	


done