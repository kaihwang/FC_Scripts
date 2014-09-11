#!/bin/sh
# script to submit jobs to cluster for preprocessing functional data.

#for control subjects
for s in 114; do
	for r in 1 2 3 4 5 6; do
		
		echo ". /etc/bashrc" >> f_${s}_${r}.sh
		echo ". ~/.bashrc" >> f_${s}_${r}.sh
		echo "" >> f_${s}_${r}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> f_${s}_${r}.sh
		
		#create separate input to avoid confusion
		echo "gzip ${s}-EPI-00${r}.nii" >> f_${s}_${r}.sh
		echo "3dcopy ${s}-EPI-00${r}.nii.gz ${s}_rest_run${r}.nii.gz" >> f_${s}_${r}.sh
		echo "mkdir /home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/" >> f_${s}_${r}.sh
		echo "mv ${s}_rest_run${r}.nii.gz /home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/" >> f_${s}_${r}.sh
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/" >> f_${s}_${r}.sh
		echo "" >> f_${s}_${r}.sh
		#run Michael's preprocessing script
		
		echo "preprocessFunctional -4d ${s}_rest_run${r}.nii.gz \\
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
		-startover" >> f_${s}_${r}.sh
		echo "" >> f_${s}_${r}.sh
		
		#convert to afni format 
		echo "3dcopy wdkmt_${s}_rest_run${r}.nii.gz ${s}_rest_proc_run${r}+tlrc" >> f_${s}_${r}.sh 
		
		# regression
		
		echo "cp /home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/motion.par \\
		/home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/motion.1D" >> f_${s}_${r}.sh
		echo "" >> f_${s}_${r}.sh
		
		
		echo "afni_restproc.py \\
		-trcut 0 \\
		-despike off \\
		-aseg /home/despo/kaihwang/Subjects/${s}/SUMA/aseg_mni+tlrc \\
		-anat /home/despo/kaihwang/Subjects/${s}/SUMA/${s}_MNI_final+tlrc \\
		-epi /home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/${s}_rest_proc_run${r}+tlrc \\
		-dest /home/despo/kaihwang/Rest/Control/${s}/Rest/reg_run${r}/ \\
		-prefix ${s}-preproc-run${r} \\
		-align off -episize 3 \\
		-dreg -regressor /home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/motion.1D \\
		-bandpass -bpassregs -polort 2 \\
		-wmsize 20 -tsnr -smooth off -script afniproc_run${r}" >> f_${s}_${r}.sh
		echo "" >> f_${s}_${r}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest/reg_run${r}/" >> f_${s}_${r}.sh
	
		echo "afni_restproc.py -apply_censor \\
		${s}-preproc-run${r}.cleanEPI+tlrc \\
		/home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/motion_info/censor_intersection.1D \\
		${s}-preproc-run${r}-censored" >> f_${s}_${r}.sh
		echo "" >> f_${s}_${r}.sh
		
		#clean up
		
		echo "rm -rf /home/despo/kaihwang/Rest/Control/${s}/Rest/reg_run${r}/tmp" >> f_${s}_${r}.sh
		echo "rm /home/despo/kaihwang/Rest/Control/${s}/Rest/run${r}/*t_*run*" >> f_${s}_${r}.sh
		
		qsub -M kaihwang -m e -e ~/tmp -o ~/tmp f_${s}_${r}.sh
	
	
	done
done