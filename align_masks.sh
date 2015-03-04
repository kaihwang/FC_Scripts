#!/bin/bash

# register and align lesion masks to MNI space.

#subjects= 128 162 163 168 176 b116 b117 b120 b121 b122 b138 b143 b144 b153
WD='/home/despoB/kaihwang/Rest/Lesion_Masks'
standard='/home/despoB/kaihwang/standard/mni_icbm152_nlin_asym_09c'

for s in 128; do

	cd ${WD}

	#3dresample -inset ${s}_native_lesion_mask.nii.gz \
	#-master /home/despoB/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_biascorr.nii.gz \
	#-prefix ${s}_native_lesion_mask_RPI.nii.gz
	fslreorient2std ${s}_native_lesion_mask.nii.gz ${s}_native_lesion_mask.nii.gz

	applywarp --interp=nn --in=${s}_native_lesion_mask.nii.gz \
	--ref=/home/despoB/kaihwang/standard/mni_icbm152_nlin_asym_09c/mni_icbm152_t1_tal_nlin_asym_09c_2mm \
	--warp=/home/despoB/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_warpcoef.nii.gz \
	-o ${s}_mni_lesion_mask_RPI.nii.gz


done