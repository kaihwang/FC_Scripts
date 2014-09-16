#!/bin/sh

#script to calculate ROIxROI connectivity matrices. Using AFNI

for s in 128 162 163 168; do
	cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest
	
	@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s.nii.gz -mat FULL -prefix ${s}_Full_corrmat -verb
	
	@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s_right.nii.gz -mat FULL -prefix ${s}_right_corrmat -verb
	
	@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s_left.nii.gz -mat FULL -prefix ${s}_left_corrmat -verb

done