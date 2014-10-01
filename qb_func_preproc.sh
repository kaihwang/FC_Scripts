#!/bin/sh
# script to submit jobs to cluster for preprocessing functional data.
# 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220
# BG Subjects b116 b117 b120 b121 b122 b138 b143 b153

#for BG subjects
for s in b122 b138 b143 b153; do
	
		
		echo ". /etc/bashrc" >> fb_${s}.sh
		echo ". ~/.bashrc" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		echo "for r in 1 2; do" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest" >> fb_${s}.sh
		
		#create separate input to avoid confusion
		echo "gzip ${s}-EPI-00\${r}.nii" >> fb_${s}.sh
		echo "3dcopy ${s}-EPI-00\${r}.nii.gz ${s}_rest_run\${r}.nii.gz" >> fb_${s}.sh
		echo "rm -rf /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/" >> fb_${s}.sh
		echo "mkdir /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/" >> fb_${s}.sh
		echo "mv ${s}_rest_run\${r}.nii.gz /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/" >> fb_${s}.sh
		echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		#run Michael's preprocessing script
		
		echo "preprocessFunctional -4d ${s}_rest_run\${r}.nii.gz \\
		-tr 2 \\
		-mprage_bet /home/despo/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_bet.nii.gz \\
		-threshold 98_2 \\
		-rescaling_method 10000_globalmedian \\
		-template_brain MNI_3mm \\
		-func_struc_dof bbr \\
		-warp_interpolation spline \\
		-constrain_to_template y \\
		-motion_censor fd=0.9,dvars=20 \\
		-nuisance_regression 6motion,csf,wm,d6motion \\
		-bandpass_filter 0.009 .08 \\
		-despike \\
		-cleanup \\
		-deoblique_all \\
		-log proctest \\
		-no_hp \\
		-smoothing_kernel 6 \\
		-slice_acquisition interleaved \\
		-warpcoef /home/despo/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_warpcoef.nii.gz \\
		-startover" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		#convert to afni format 
		#echo "3dcopy wdkmt_${s}_rest_run\${r}.nii.gz ${s}_rest_proc_run\${r}+tlrc" >> fb_${s}.sh 
		
		# regression
		
		#echo "cp /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/motion.par \\
		#/home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/motion.1D" >> fb_${s}.sh
		#echo "" >> fb_${s}.sh
		
		
		#echo "afni_restproc.py \\
		#-trcut 0 \\
		#-despike off \\
		#-aseg /home/despo/kaihwang/Subjects/${s}/SUMA/aseg_mni+tlrc \\
		#-anat /home/despo/kaihwang/Subjects/${s}/SUMA/${s}_MNI_final+tlrc \\
		#-epi /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/${s}_rest_proc_run\${r}+tlrc \\
		#-dest /home/despo/kaihwang/Rest/BG/${s}/Rest/reg_run\${r}/ \\
		#-prefix ${s}-preproc-run\${r} \\
		#-align off -episize 3 \\
		#-dreg -regressor /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/motion.1D \\
		#-bandpass -bpassregs -polort 2 \\
		#-wmsize 20 -tsnr -smooth off -script afniproc_run\${r}" >> fb_${s}.sh
		#echo "" >> fb_${s}.sh
		
		#echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest/reg_run\${r}/" >> fb_${s}.sh
	
		#echo "afni_restproc.py -apply_censor \\
		#${s}-preproc-run\${r}.cleanEPI+tlrc \\
		#/home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/motion_info/censor_intersection.1D \\
		#${s}-preproc-run\${r}-censored" >> fb_${s}.sh
		#echo "" >> fb_${s}.sh
		
		#clean up
		
		#echo "rm -rf /home/despo/kaihwang/Rest/BG/${s}/Rest/reg_run\${r}/tmp" >> fb_${s}.sh
		#echo "rm /home/despo/kaihwang/Rest/BG/${s}/Rest/run\${r}/*t_*run*" >> fb_${s}.sh
		
		echo "done" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		#echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest" >> fb_${s}.sh
		#echo "" >> fb_${s}.sh
		
		#echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt \\
		#reg_run1/${s}-preproc-run1-censored+tlrc \\
		#reg_run2/${s}-preproc-run2-censored+tlrc" >> fb_${s}.sh
		#echo "" >> fb_${s}.sh
		#echo "" >> fb_${s}.sh
		
		#echo 'mv reg*/*tsnr* .' >> fb_${s}.sh
		#echo 'rm -rf reg_run*' >> fb_${s}.sh
		
		qsub -M kaihwang -l mem_free=5G -m e -e ~/tmp -o ~/tmp fb_${s}.sh
		sleep 12.34m
	
done