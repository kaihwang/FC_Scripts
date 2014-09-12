#!/bin/sh
# script to concatenate preprocessed runs and cleanup

for s in 114 116 117 118 119 201 203 204 205 206 207 208 209 210 212 213 214 215 216 217 218 219 220; do
	
	echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> cc_${s}.sh
	echo "" >> cc_${s}.sh
	
	echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt \\
	reg_run1/${s}-preproc-run1-censored+tlrc \\
	reg_run2/${s}-preproc-run2-censored+tlrc \\
	reg_run3/${s}-preproc-run3-censored+tlrc \\
	reg_run4/${s}-preproc-run4-censored+tlrc \\
	reg_run5/${s}-preproc-run5-censored+tlrc \\
	reg_run6/${s}-preproc-run6-censored+tlrc" >> cc_${s}.sh
	echo "" >> cc_${s}.sh
	
	echo 'mv reg*/*tsnr* .' >> cc_${s}.sh
	
	echo 'rm -rf reg_run*' >> cc_${s}.sh

	#qsub -M kaihwang -m e -e ~/tmp -o ~/tmp cc_${s}.sh

done