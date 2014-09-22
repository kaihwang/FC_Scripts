#!/bin/sh

# tha patients
#for s in 128 162 163 168; do
	#cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest
	#rm ${s}_tsnr_mean.nii.gz
	#3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc
	#rm ${s}_tsnr_mask.nii.gz
	#3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-10)' -prefix ${s}_tsnr_mask.nii.gz
	
	
#done

# BG patients
for s in b116 b117 b120 b121 b122 b138 b143 b153; do
	cd /home/despo/kaihwang/Rest/BG/${s}/Rest
	rm ${s}_tsnr_mean.nii.gz
	3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc
	rm ${s}_tsnr_mask.nii.gz
	3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-10)' -prefix ${s}_tsnr_mask.nii.gz
	
	
done

# control
for s in 114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220; do
	cd /home/despo/kaihwang/Rest/Control/${s}/Rest
	rm ${s}_tsnr_mean.nii.gz
	3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc ${s}-preproc-run3.tsnr+tlrc ${s}-preproc-run4.tsnr+tlrc ${s}-preproc-run5.tsnr+tlrc ${s}-preproc-run6.tsnr+tlrc
	#rm ${s}_tsnr_mask.nii.gz
	#3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-10)' -prefix ${s}_tsnr_mask.nii.gz
	
	
done

cd /home/despo/kaihwang/Rest/Control/

3dMean -prefix control_tsnr_mean.nii.gz /home/despo/kaihwang/Rest/Control/114/Rest/114_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/116/Rest/116_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/117/Rest/117_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/118/Rest/118_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/119/Rest/119_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/201/Rest/201_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/203/Rest/203_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/204/Rest/204_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/205/Rest/205_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/206/Rest/206_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/207/Rest/207_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/208/Rest/208_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/209/Rest/209_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/210/Rest/210_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/211/Rest/211_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/212/Rest/212_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/213/Rest/213_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/214/Rest/214_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/216/Rest/216_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/217/Rest/217_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/218/Rest/218_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/219/Rest/219_tsnr_mean.nii.gz \
/home/despo/kaihwang/Rest/Control/220/Rest/220_tsnr_mean.nii.gz