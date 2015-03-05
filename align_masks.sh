#!/bin/bash

# register and align lesion masks to MNI space.

#subjects= 128 162 163 168 176 b116 b117 b120 b121 b122 b138 b143 b144 b153
WD='/home/despoB/kaihwang/Rest/Lesion_Masks'
standard='/home/despoB/kaihwang/standard/mni_icbm152_nlin_asym_09c'

for s in 162 163 168 176; do

	#cd ${WD}
	#mv ${s}-T1.nii.gz ${s}
	#mv ${s}_native_lesion_mask.nii.gz ${s}

	cd ${WD}/${s}
	#preprocessMprage -r MNI_2mm -b "-R -S -B -f 0.05 -g -0.3" -no_bias -o ${s}_MNI_final.nii.gz -n ${s}-T1.nii.gz

	applywarp --ref=/home/despoB/kaihwang/standard/mni_icbm152_nlin_asym_09c/mni_icbm152_t1_tal_nlin_asym_09c_2mm \
	--interp=nn \
	--in=${s}_native_lesion_mask.nii.gz --warp=${s}-T1_warpcoef.nii.gz -o ../${s}_mni_lesion_mask.nii.gz

	#cp ${s}_mni_lesion_mask.nii.gz ${WD}/
	cd ${WD}/
	#rm ${s}_mni_lesion_mask_RPI.nii.gz
	3dresample -master Thalamus_voxel_dices_scaled_25prob_2mm.nii.gz -inset ${s}_mni_lesion_mask.nii.gz -prefix ${s}_mni_lesion_mask_RPI.nii.gz
	3dmaskdump -mask ${s}_mni_lesion_mask_RPI.nii.gz -noijk -nozero Thalamus_voxel_dices_scaled_25prob_2mm.nii.gz > ${s}_lesioned_voxels


	#3dWarp -deoblique -prefix ${s}_native_lesion_mask_d.nii.gz -quintic ${s}_native_lesion_mask.nii.gz
	# 3dresample -inset ${s}_native_lesion_mask.nii.gz \
	# -master /home/despoB/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_bet_initial.nii.gz \
	# -prefix ${s}_native_lesion_mask_RPI.nii.gz
	# #fslreorient2std ${s}_native_lesion_mask.nii.gz ${s}_native_lesion_mask.nii.gz

	# applywarp --interp=nn --in=${s}_native_lesion_mask_RPI.nii.gz \
	# --ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
	# --warp=/home/despoB/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_warpcoef.nii.gz \
	# -o ${s}_mni_lesion_mask_RPI.nii.gz

	# 

done

for s in b116 b117 b120 b121 b122 b138 b143 b144 b153; do

# 	cd ${WD}
# 	mv ${s}-T1.nii.gz ${s}
# 	mv ${s}_native_lesion_mask.nii.gz ${s}

	cd ${WD}/${s}
	#preprocessMprage -r MNI_2mm -b "-R -S -B -f 0.05 -g -0.3" -no_bias -o ${s}_MNI_final.nii.gz -n ${s}-T1.nii.gz

	applywarp --ref=/home/despoB/kaihwang/standard/mni_icbm152_nlin_asym_09c/mni_icbm152_t1_tal_nlin_asym_09c_2mm \
	--interp=nn \
	--in=${s}_native_lesion_mask.nii.gz --warp=${s}-T1_warpcoef.nii.gz -o ../${s}_mni_lesion_mask.nii.gz

	#cp ${s}_mni_lesion_mask.nii.gz ${WD}/
	cd ${WD}/
	#rm ${s}_mni_lesion_mask_RPI.nii.gz
	3dresample -master Striatum_voxel_dices_scaled_25prob_2mm.nii.gz -inset ${s}_mni_lesion_mask.nii.gz -prefix ${s}_mni_lesion_mask_RPI.nii.gz
	3dmaskdump -mask ${s}_mni_lesion_mask_RPI.nii.gz -noijk -nozero Striatum_voxel_dices_scaled_25prob_2mm.nii.gz > ${s}_lesioned_voxels

# 	cd ${WD}/${s}
# 	preprocessMprage -r MNI_2mm -b -R -S -B -f 0.05 -g -0.3 -no_bias -o ${s}_MNI_final.nii.gz -n ${s}-T1.nii.gz

# 	# 3dWarp -deoblique -prefix ${s}_native_lesion_mask_d.nii.gz -quintic ${s}_native_lesion_mask.nii.gz
# 	# 3dresample -inset ${s}_native_lesion_mask_d.nii.gz \
# 	# -master /home/despoB/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_bet_initial.nii.gz \
# 	# -prefix ${s}_native_lesion_mask_RPI.nii.gz
# 	# #fslreorient2std ${s}_native_lesion_mask.nii.gz ${s}_native_lesion_mask.nii.gz

# 	# applywarp --interp=nn --in=${s}_native_lesion_mask_RPI.nii.gz \
# 	# --ref=${FSLDIR}/data/standard/MNI152_T1_2mm \
# 	# --warp=/home/despoB/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_warpcoef.nii.gz \
# 	# -o ${s}_mni_lesion_mask_RPI.nii.gz 

# 	# 3dmaskdump -mask ${s}_mni_lesion_mask_RPI.nii.gz -noijk Striatum_voxel_dices_scaled_25prob_2mm.nii.gz > ${s}_lesioned_voxels

done