#!/bin/sh

#script to calculate ROIxROI connectivity matrices. Using AFNI

for s in 128 162 163 168; do
	cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest
	
	#create SNR mask.
	rm ${s}_tsnr_mean.nii.gz
	3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc
	rm ${s}_tsnr_mask.nii.gz
	3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-15)' -prefix ${s}_tsnr_mask.nii.gz 
	
	# connectivity
	rm *corrmat*
	
	3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/Lesion/bb264_s.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/Lesion/bb264_s_right.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/Lesion/bb264_s_left.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	#ln -s /home/despo/kaihwang/Subjects/128/SUMA/128_MNI_final.nii.gz 128_MNI_final.nii.gz
	#@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s.nii.gz -mat FULL -prefix ${s}_Full_corrmat -verb
	
	#@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s_right.nii.gz -mat FULL -prefix ${s}_right_corrmat -verb
	
	#@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s_left.nii.gz -mat FULL -prefix ${s}_left_corrmat -verb

	
	tail -n 128 ${s}_Left_corrmat_000.netcc > /home/despo/kaihwang/Rest/Lesion/${s}_left_corrmat
	tail -n 143 ${s}_Right_corrmat_000.netcc > /home/despo/kaihwang/Rest/Lesion/${s}_right_corrmat
	tail -n 254 ${s}_Full_corrmat_000.netcc > /home/despo/kaihwang/Rest/Lesion/${s}_full_corrmat

done