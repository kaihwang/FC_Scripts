#!/bin/sh
# script to submit jobs to cluster for preprocessing functional data.
# 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220

#for control subjects
for s in 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220; do
	
		
		echo ". /etc/bashrc" >> f_${s}.sh
		echo ". ~/.bashrc" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		echo "for r in 1 2 3 4 5 6; do" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> f_${s}.sh
		
		#create separate input to avoid confusion
		echo "gzip ${s}-EPI-00\${r}.nii" >> f_${s}.sh
		echo "3dcopy ${s}-EPI-00\${r}.nii.gz ${s}_rest_run\${r}.nii.gz" >> f_${s}.sh
		echo "rm -rf /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/" >> f_${s}.sh
		echo "mkdir /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/" >> f_${s}.sh
		echo "mv ${s}_rest_run\${r}.nii.gz /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/" >> f_${s}.sh
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/" >> f_${s}.sh
		echo "" >> f_${s}.sh
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
		-wavelet_despike \\
		-cleanup \\
		-deoblique_all \\
		-log proctest \\
		-motion_sinc y \\
		-no_hp \\
		-no_smooth \\
		-slice_acquisition interleaved \\
		-warpcoef /home/despo/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_warpcoef.nii.gz \\
		-startover" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		#convert to afni format 
		echo "3dcopy wdkmt_${s}_rest_run\${r}.nii.gz ${s}_rest_proc_run\${r}+tlrc" >> f_${s}.sh 
		
		# regression
		
		echo "cp /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/motion.par \\
		/home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/motion.1D" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		
		echo "afni_restproc.py \\
		-trcut 0 \\
		-despike off \\
		-aseg /home/despo/kaihwang/Subjects/${s}/SUMA/aseg_mni+tlrc \\
		-anat /home/despo/kaihwang/Subjects/${s}/SUMA/${s}_MNI_final+tlrc \\
		-epi /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/${s}_rest_proc_run\${r}+tlrc \\
		-dest /home/despo/kaihwang/Rest/Control/${s}/Rest/reg_run\${r}/ \\
		-prefix ${s}-preproc-run\${r} \\
		-align off -episize 3 \\
		-dreg -regressor /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/motion.1D \\
		-bandpass -bpassregs -polort 2 \\
		-wmsize 20 -tsnr -smooth off -script afniproc_run\${r}" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest/reg_run\${r}/" >> f_${s}.sh
	
		echo "afni_restproc.py -apply_censor \\
		${s}-preproc-run\${r}.cleanEPI+tlrc \\
		/home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/motion_info/censor_intersection.1D \\
		${s}-preproc-run\${r}-censored" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		#clean up
		
		echo "rm -rf /home/despo/kaihwang/Rest/Control/${s}/Rest/reg_run\${r}/tmp" >> f_${s}.sh
		echo "rm /home/despo/kaihwang/Rest/Control/${s}/Rest/run\${r}/*t_*run*" >> f_${s}.sh
		
		echo "done" >> f_${s}.sh
		echo "" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt \\
		reg_run1/${s}-preproc-run1-censored+tlrc \\
		reg_run2/${s}-preproc-run2-censored+tlrc \\
		reg_run3/${s}-preproc-run3-censored+tlrc \\
		reg_run4/${s}-preproc-run4-censored+tlrc \\
		reg_run5/${s}-preproc-run5-censored+tlrc \\
		reg_run6/${s}-preproc-run6-censored+tlrc" >> f_${s}.sh
		echo "" >> f_${s}.sh
		echo "" >> f_${s}.sh
		
		echo 'mv reg*/*tsnr* .' >> f_${s}.sh
		echo 'rm -rf reg_run*' >> f_${s}.sh
		
		qsub -M kaihwang -l mem_free=5G -m e -e ~/tmp -o ~/tmp f_${s}.sh
	
	
done