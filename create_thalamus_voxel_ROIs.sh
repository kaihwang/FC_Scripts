#!/bin/bash

#script to create thalamus voxel wise ROIs

cd /home/despoB/kaihwang/Rest/ROIs

# dump out each individual thalamus's voxel coordinate (in MNI), and give an integer index
3dmaskdump -mask Thalamus-maxprob-thr50-2mm.nii.gz Thalamus-maxprob-thr50-2mm.nii.gz | cat -n | awk '{print $2 " " $3 " " $4 " " $1}' > tmp

#create voxel-wise mask
3dUndump -master Thalamus-maxprob-thr50-2mm.nii.gz -prefix thalamus_voxel_mask_mni2mm.nii.gz tmp

# create cortical ROI mask using WashU's parcellation, and then scaled it so doesn't overlap with the thalamus mask
3dmaskdump -mask WashU333_2mm_mask.nii.gz WashU333_2mm.nii.gz | awk '{print $1 " " $2  " " $3 " " $4+2039 }' > tmp
3dUndump -master Thalamus-maxprob-thr50-2mm.nii.gz -prefix WashU333_2mm_added.nii.gz tmp

#combine the cortical and thalamus masks
3dcalc -a thalamus_voxel_mask_mni2mm.nii.gz -b WashU333_2mm_added.nii.gz -expr 'a+b' -prefix thalamus_plus_cortical_ROIs.nii.gz


# below is a test run on doing seed-based connectivity with the new ROI mask
cd /tmp
mkdir 100307NetCorr
cd 100307NetCorr
3dTcat -prefix input.nii.gz /home/despoB/kaihwang/Rest/connectome/100307/MNINonLinear/rfMRI_REST1_LR_reg_bp.nii.gz \
/home/despoB/kaihwang/Rest/connectome/100307/MNINonLinear/rfMRI_REST1_RL_reg_bp.nii.gz

3dNetCorr -prefix 100307_thalamus_voxel_corrmat -inset input.nii.gz \
-in_rois /home/despoB/kaihwang/Rest/ROIs/thalamus_plus_cortical_ROIs.nii.gz