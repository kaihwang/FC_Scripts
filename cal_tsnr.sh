#!/bin/sh

for s in 128 162 163 168; do
	cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest
	rm ${s}_tsnr_mean.nii.gz
	3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc
	rm ${s}_tsnr_mask.nii.gz
	3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-10)' -prefix ${s}_tsnr_mask.nii.gz
	
	
done