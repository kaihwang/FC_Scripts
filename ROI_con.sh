#!/bin/sh

#script to calculate ROIxROI connectivity matrices. Using AFNI

# tha patients
for s in 128 162 163 168; do
	cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest
	
	#create SNR mask.
	#rm ${s}_tsnr_mean.nii.gz
	#3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc
	#rm ${s}_tsnr_mask.nii.gz
	#3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-15)' -prefix ${s}_tsnr_mask.nii.gz 
	
	# connectivity
	rm *corrmat*
	
	3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_TSNR_masked.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_right_TSNR_masked.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_left_TSNR_masked.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	
	#ln -s /home/despo/kaihwang/Subjects/128/SUMA/128_MNI_final.nii.gz 128_MNI_final.nii.gz
	#@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s.nii.gz -mat FULL -prefix ${s}_Full_corrmat -verb
	
	#@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s_right.nii.gz -mat FULL -prefix ${s}_right_corrmat -verb
	
	#@ROI_Corr_Mat -ts ${s}-rest-preproc-cen.nii.gz -roi /home/despo/kaihwang/Rest/Lesion/bb264_s_left.nii.gz -mat FULL -prefix ${s}_left_corrmat -verb

	
	tail -n 126 ${s}_Left_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/t${s}_left_corrmat
	tail -n 141 ${s}_Right_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/t${s}_right_corrmat
	tail -n 250 ${s}_Full_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/t${s}_full_corrmat

done


# BG patients
for s in b116 b117 b120 b121 b122 b138 b143 b153; do
	cd /home/despo/kaihwang/Rest/BG/${s}/Rest
	
	# connectivity
	rm *corrmat*
	
	3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_TSNR_masked.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_right_TSNR_masked.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_left_TSNR_masked.nii.gz -fish_z -mask ${s}_tsnr_mask.nii.gz
	
	tail -n 126 ${s}_Left_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/${s}_left_corrmat
	tail -n 141 ${s}_Right_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/${s}_right_corrmat
	tail -n 250 ${s}_Full_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/${s}_full_corrmat

done

# Control
for s in 114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220; do
	cd /home/despo/kaihwang/Rest/Control/${s}/Rest
	
	# connectivity
	rm *corrmat*
	
	3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_TSNR_masked.nii.gz -fish_z 
	3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_right_TSNR_masked.nii.gz -fish_z
	3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/bb264_s_left_TSNR_masked.nii.gz -fish_z
	
	tail -n 126 ${s}_Left_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/c${s}_left_corrmat
	tail -n 141 ${s}_Right_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/c${s}_right_corrmat
	tail -n 250 ${s}_Full_corrmat_000.netcc > /home/despo/kaihwang/bin/Thalamo/Data/c${s}_full_corrmat

done