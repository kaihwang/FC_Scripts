#!/bin/bash 
# script to run ALL functional processing......
# for th patients

for s in 162 163 168 176; do
	
		
		echo ". /etc/bashrc" >> ft_${s}.sh
		echo ". ~/.bashrc" >> ft_${s}.sh
		echo "" >> ft_${s}.sh
		
		echo "for r in 1 2; do" >> ft_${s}.sh
		echo "" >> ft_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest" >> ft_${s}.sh
		
		#create separate input to avoid confusion
		echo "gzip ${s}-EPI-00\${r}.nii" >> ft_${s}.sh
		echo "3dcopy ${s}-EPI-00\${r}.nii.gz ${s}_rest_run\${r}.nii.gz" >> ft_${s}.sh
		echo "rm -rf /home/despo/kaihwang/Rest/Lesion/${s}/Rest/NNrun\${r}/" >> ft_${s}.sh
		echo "mkdir /home/despo/kaihwang/Rest/Lesion/${s}/Rest/NNrun\${r}/" >> ft_${s}.sh
		echo "mv ${s}_rest_run\${r}.nii.gz /home/despo/kaihwang/Rest/Lesion/${s}/Rest/NNrun\${r}/" >> ft_${s}.sh
		echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest/NNrun\${r}/" >> ft_${s}.sh
		echo "" >> ft_${s}.sh
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
		-motion_sinc \\
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
		-startover" >> ft_${s}.sh
		echo "" >> ft_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest/NNrun\${r}/" >> ft_${s}.sh
		echo "3dWarp -deoblique -prefix dbrnswdkmt_${s}_rest_run\${r}_6.nii.gz -quintic brnswdkmt_${s}_rest_run\${r}_6.nii.gz" >> ft_${s}.sh
		echo "" >> ft_${s}.sh
		
		echo "done" >> ft_${s}.sh
		echo "" >> ft_${s}.sh
		echo "" >> ft_${s}.sh
		
		# concate and tsnr
		echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest" >> ft_${s}.sh
		echo "" >> ft_${s}.sh

		echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt++ \\
		NNrun1/dbrnswdkmt_${s}_rest_run1_6.nii.gz \\
		NNrun2/dbrnswdkmt_${s}_rest_run2_6.nii.gz " >> ft_${s}.sh
		echo "" >> ft_${s}.sh

		echo "3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> ft_${s}.sh
		echo "3dTstat -mean -prefix m2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> ft_${s}.sh

		echo "3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> ft_${s}.sh
		echo "3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> ft_${s}.sh

		echo "3dcalc -a m1.nii.gz -b m2.nii.gz -c s1.nii.gz -d s2.nii.gz -expr '((a/c)+(b/d))/2' -prefix ${s}_tsnr_mean.nii.gz" >> ft_${s}.sh

		echo "rm m*.nii.gz; rm s*.nii.gz" >> ft_${s}.sh
		#echo "rm NNrun*/*t_*" >> ft_${s}.sh
		echo "" >> ft_${s}.sh

		echo "rm ${s}_tsnr_mask.nii.gz" >> ft_${s}.sh
		echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> ft_${s}.sh 
		echo "" >> ft_${s}.sh

		# connectivity
		echo "rm *corrmat*" >> ft_${s}.sh
		echo "" >> ft_${s}.sh

		echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ft_${s}.sh
		echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ft_${s}.sh
		echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ft_${s}.sh
		echo "" >> ft_${s}.sh

		echo 'for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do' >> ft_${s}.sh
			echo "num=\$(expr \$(wc -l ${s}_Full_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ft_${s}.sh
			echo "tail -n \$num ${s}_Full_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_full_corrmat_\${p}" >> ft_${s}.sh
			echo "" >> ft_${s}.sh

			echo "num=\$(expr \$(wc -l ${s}_Right_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ft_${s}.sh
			echo "tail -n \$num ${s}_Right_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Right_corrmat_\${p}" >> ft_${s}.sh
			echo "" >> ft_${s}.sh

			echo "num=\$(expr \$(wc -l ${s}_Left_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ft_${s}.sh
			echo "tail -n \$num ${s}_Left_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Left_corrmat_\${p}" >> ft_${s}.sh
			echo "" >> ft_${s}.sh

		echo "done" >> ft_${s}.sh
		
		#graph theory
		echo "addpath(genpath('/home/despo/kaihwang/bin/'));" >> g${s}.m
		echo "addpath(genpath('/home/despo/kaihwang/matlab/'));" >> g${s}.m
		echo "[Adj, Graph] = cal_graph('${s}');" >> g${s}.m
		echo "save /home/despo/kaihwang/Rest/Graph/g_${s}.mat; exit;" >> g${s}.m

		echo "matlab -nodisplay -nosplash < /home/despo/kaihwang/bin/Thalamo/g${s}.m" >> ft_${s}.sh
		
		qsub -V -M kaihwang -l mem_free=10G -m e -e ~/tmp -o ~/tmp ft_${s}.sh
		#sleep 23.45m

done		
