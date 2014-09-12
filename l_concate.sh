#!/bin/sh
# script to concatenate preprocessed runs and cleanup

for s in 128 162 163 168; do
	
	echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest" >> cc_${s}.sh
	echo "" >> cc_${s}.sh
	
	echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt \\
	reg_run1/${s}-preproc-run1-censored+tlrc \\
	reg_run2/${s}-preproc-run2-censored+tlrc" >> cc_${s}.sh
	echo "" >> cc_${s}.sh
	
	echo 'mv reg*/*tsnr* .' >> cc_${s}.sh
	
	echo 'rm -rf reg_run*' >> cc_${s}.sh

	#qsub -M kaihwang -m e -e ~/tmp -o ~/tmp cc_${s}.sh

done