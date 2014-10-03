#!/bin/sh
# script to concatenate preprocessed runs and do tsNR

#for s in 176; do
	
#	echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest" >> cc_${s}.sh
#	echo "" >> cc_${s}.sh
	
#	echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt++ \\
#	NNrun1/brnswdkmt_${s}_rest_run1_6.nii.gz \\
#	NNrun2/brnswdkmt_${s}_rest_run2_6.nii.gz " >> cc_${s}.sh
#	echo "" >> cc_${s}.sh
	
#	echo "3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -mean -prefix m2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> cc_${s}.sh
	
#	echo "3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> cc_${s}.sh
	
#	echo "3dcalc -a m1.nii.gz -b m2.nii.gz -c s1.nii.gz -d s2.nii.gz -expr '((a/c)+(b/d))/2' -prefix ${s}_tsnr_mean.nii.gz" >> cc_${s}.sh
	
#	echo "rm m*.nii.gz; rm s*.nii.gz" >> cc_${s}.sh
 
	#qsub -M kaihwang -m e -e ~/tmp -o ~/tmp cc_${s}.sh
	
#done


for s in b122 b138 b143 b153; do
	
	echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest" >> cc_${s}.sh
	echo "" >> cc_${s}.sh
	
	echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt++ \\
	NNrun1/brnswdkmt_${s}_rest_run1_6.nii.gz \\
	NNrun2/brnswdkmt_${s}_rest_run2_6.nii.gz " >> cc_${s}.sh
	echo "" >> cc_${s}.sh
	
	echo "3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> cc_${s}.sh
	echo "3dTstat -mean -prefix m2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> cc_${s}.sh
	
	echo "3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> cc_${s}.sh
	echo "3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> cc_${s}.sh
	
	echo "3dcalc -a m1.nii.gz -b m2.nii.gz -c s1.nii.gz -d s2.nii.gz -expr '((a/c)+(b/d))/2' -prefix ${s}_tsnr_mean.nii.gz" >> cc_${s}.sh
	
	echo "rm m*.nii.gz; rm s*.nii.gz" >> cc_${s}.sh
 
	qsub -V -m e -e ~/tmp -o ~/tmp cc_${s}.sh

done

#for s in 216; do
	
#	echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> cc_${s}.sh
#	echo "" >> cc_${s}.sh
	
#	echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt++ \\
#	NNrun1/brnswdkmt_${s}_rest_run1_6.nii.gz \\
#	NNrun2/brnswdkmt_${s}_rest_run2_6.nii.gz \\
#	NNrun3/brnswdkmt_${s}_rest_run3_6.nii.gz \\
#	NNrun4/brnswdkmt_${s}_rest_run4_6.nii.gz \\
#	NNrun5/brnswdkmt_${s}_rest_run5_6.nii.gz \\
#	NNrun6/brnswdkmt_${s}_rest_run6_6.nii.gz " >> cc_${s}.sh
#	echo "" >> cc_${s}.sh
	
#	echo "3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -mean -prefix m3.nii.gz NNrun3/wdkmt_${s}_rest_run3.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -mean -prefix m4.nii.gz NNrun4/wdkmt_${s}_rest_run4.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -mean -prefix m5.nii.gz NNrun5/wdkmt_${s}_rest_run5.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -mean -prefix m6.nii.gz NNrun6/wdkmt_${s}_rest_run6.nii.gz" >> cc_${s}.sh
	
#	echo "3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -stdev -prefix s3.nii.gz NNrun3/wdkmt_${s}_rest_run3.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -stdev -prefix s4.nii.gz NNrun4/wdkmt_${s}_rest_run4.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -stdev -prefix s5.nii.gz NNrun5/wdkmt_${s}_rest_run5.nii.gz" >> cc_${s}.sh
#	echo "3dTstat -stdev -prefix s6.nii.gz NNrun6/wdkmt_${s}_rest_run6.nii.gz" >> cc_${s}.sh
	
#	echo "3dcalc -a m1.nii.gz -b s1.nii.gz -c m2.nii.gz -d s2.nii.gz -e m3.nii.gz -f s3.nii.gz -g m4.nii.gz -h s4.nii.gz -i m5.nii.gz -j s5.nii.gz -k m6.nii.gz -l s6.nii.gz -expr '((a/b)+(c/d)+(e/f)+(g/h)+(i/j)+(k/l))/6' -prefix ${s}_tsnr_mean.nii.gz" >> cc_${s}.sh
	
#	echo "rm m*.nii.gz; rm s*.nii.gz" >> cc_${s}.sh
 
#	qsub -V -m e -e ~/tmp -o ~/tmp cc_${s}.sh

#done