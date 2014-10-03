#!/bin/bash 
# script to run ALL functional processing......
# for bg patients

for s in b116 b117 b120 b121 b122 b138 b143 b152; do
	
		
		echo ". /etc/bashrc" >> fb_${s}.sh
		echo ". ~/.bashrc" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		echo "for r in 1 2; do" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest" >> fb_${s}.sh
		
		#create separate input to avoid confusion
		echo "gzip ${s}-EPI-00\${r}.nii" >> fb_${s}.sh
		echo "3dcopy ${s}-EPI-00\${r}.nii.gz ${s}_rest_run\${r}.nii.gz" >> fb_${s}.sh
		echo "rm -rf /home/despo/kaihwang/Rest/BG/${s}/Rest/NNrun\${r}/" >> fb_${s}.sh
		echo "mkdir /home/despo/kaihwang/Rest/BG/${s}/Rest/NNrun\${r}/" >> fb_${s}.sh
		echo "mv ${s}_rest_run\${r}.nii.gz /home/despo/kaihwang/Rest/BG/${s}/Rest/NNrun\${r}/" >> fb_${s}.sh
		echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest/NNrun\${r}/" >> fb_${s}.sh
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
		-wavelet_despike \\
		-wavelet_m1000 \\
		-st_first \\
		-cleanup \\
		-log preproc \\
		-no_hp \\
		-smoothing_kernel 6 \\
		-slice_acquisition interleaved \\
		-warpcoef /home/despo/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_warpcoef.nii.gz \\
		-startover" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest/NNrun\${r}/" >> fb_${s}.sh
		echo "3dWarp -deoblique -prefix dbrnswdkmt_${s}_rest_run\${r}_6.nii.gz -quintic brnswdkmt_${s}_rest_run\${r}_6.nii.gz" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		echo "done" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		echo "" >> fb_${s}.sh
		
		# concate and tsnr
		echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest" >> fb_${s}.sh
		echo "" >> fb_${s}.sh

		echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt++ \\
		NNrun1/dbrnswdkmt_${s}_rest_run1_6.nii.gz \\
		NNrun2/dbrnswdkmt_${s}_rest_run2_6.nii.gz " >> fb_${s}.sh
		echo "" >> fb_${s}.sh

		echo "3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> fb_${s}.sh
		echo "3dTstat -mean -prefix m2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> fb_${s}.sh

		echo "3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> fb_${s}.sh
		echo "3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> fb_${s}.sh

		echo "3dcalc -a m1.nii.gz -b m2.nii.gz -c s1.nii.gz -d s2.nii.gz -expr '((a/c)+(b/d))/2' -prefix ${s}_tsnr_mean.nii.gz" >> fb_${s}.sh

		echo "rm m*.nii.gz; rm s*.nii.gz" >> fb_${s}.sh
		echo "rm NNrun*/*t_*" >> fb_${s}.sh
		echo "" >> fb_${s}.sh

		echo "rm ${s}_tsnr_mask.nii.gz" >> fb_${s}.sh
		echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> fb_${s}.sh 
		echo "" >> fb_${s}.sh

		# connectivity
		echo "rm *corrmat*" >> fb_${s}.sh
		echo "" >> fb_${s}.sh

		echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fb_${s}.sh
		echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_right_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fb_${s}.sh
		echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_left_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fb_${s}.sh
		echo "" >> fb_${s}.sh

		echo 'for p in $(seq 21 42); do' >> fb_${s}.sh
			echo "num=\$(expr \$(wc -l ${s}_Full_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fb_${s}.sh
			echo "tail -n \$num ${s}_Full_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_full_corrmat_\${p}" >> fb_${s}.sh
			echo "" >> fb_${s}.sh

			echo "num=\$(expr \$(wc -l ${s}_Right_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fb_${s}.sh
			echo "tail -n \$num ${s}_Right_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Right_corrmat_\${p}" >> fb_${s}.sh
			echo "" >> fb_${s}.sh

			echo "num=\$(expr \$(wc -l ${s}_Left_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fb_${s}.sh
			echo "tail -n \$num ${s}_Left_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Left_corrmat_\${p}" >> fb_${s}.sh
			echo "" >> fb_${s}.sh

		echo "done" >> fb_${s}.sh
		
		#graph theory
		echo "addpath(genpath('/home/despo/kaihwang/bin/'));" >> g${s}.m
		echo "addpath(genpath('/home/despo/kaihwang/matlab/'));" >> g${s}.m
		echo "[Adj, Graph] = cal_graph('${s}');" >> g${s}.m
		echo "save /home/despo/kaihwang/Rest/Graph/g_${s}.mat; exit;" >> g${s}.m

		echo "matlab -nodisplay -nosplash < /home/despo/kaihwang/bin/Thalamo/g${s}.m" >> fb_${s}.sh
		
		qsub -V -M kaihwang -l mem_free=9G -m e -e ~/tmp -o ~/tmp fb_${s}.sh
		sleep 19.54m

done		
