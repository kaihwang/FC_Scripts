#!/bin/bash 
# script to run ALL functional processing......
# for controls

for s in 114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220; do
	
		
		echo ". /etc/bashrc" >> fc_${s}.sh
		echo ". ~/.bashrc" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		
		echo "for r in 1 2 3 4 5 6; do" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> fc_${s}.sh
		
		#create separate input to avoid confusion
		echo "gzip ${s}-EPI-00\${r}.nii" >> fc_${s}.sh
		echo "3dcopy ${s}-EPI-00\${r}.nii.gz ${s}_rest_run\${r}.nii.gz" >> fc_${s}.sh
		echo "rm -rf /home/despo/kaihwang/Rest/Control/${s}/Rest/NNrun\${r}/" >> fc_${s}.sh
		echo "mkdir /home/despo/kaihwang/Rest/Control/${s}/Rest/NNrun\${r}/" >> fc_${s}.sh
		echo "mv ${s}_rest_run\${r}.nii.gz /home/despo/kaihwang/Rest/Control/${s}/Rest/NNrun\${r}/" >> fc_${s}.sh
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest/NNrun\${r}/" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		
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
		-motion_sinc y \\
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
		-startover" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest/NNrun\${r}/" >> fc_${s}.sh
		echo "3dWarp -deoblique -prefix dbrnswdkmt_${s}_rest_run\${r}_6.nii.gz -quintic brnswdkmt_${s}_rest_run\${r}_6.nii.gz" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		
		echo "done" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		
		# concate and tsnr
		echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> fc_${s}.sh
		echo "" >> fc_${s}.sh
		
		echo "rm ${s}-rest-preproc-cen.nii.gz" >> fc_${s}.sh
		echo "3dTcat -prefix ${s}-rest-preproc-cen.nii.gz -rlt++ \\
		NNrun1/dbrnswdkmt_${s}_rest_run1_6.nii.gz \\
		NNrun2/dbrnswdkmt_${s}_rest_run2_6.nii.gz \\
		NNrun3/dbrnswdkmt_${s}_rest_run3_6.nii.gz \\
		NNrun4/dbrnswdkmt_${s}_rest_run4_6.nii.gz \\
		NNrun5/dbrnswdkmt_${s}_rest_run5_6.nii.gz \\
		NNrun6/dbrnswdkmt_${s}_rest_run6_6.nii.gz " >> fc_${s}.sh
		echo "" >> fc_${s}.sh

		echo "3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> fc_${s}.sh
		echo "3dTstat -mean -prefix m2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> fc_${s}.sh
		echo "3dTstat -mean -prefix m3.nii.gz NNrun3/wdkmt_${s}_rest_run3.nii.gz" >> fc_${s}.sh
		echo "3dTstat -mean -prefix m4.nii.gz NNrun4/wdkmt_${s}_rest_run4.nii.gz" >> fc_${s}.sh
		echo "3dTstat -mean -prefix m5.nii.gz NNrun5/wdkmt_${s}_rest_run5.nii.gz" >> fc_${s}.sh
		echo "3dTstat -mean -prefix m6.nii.gz NNrun6/wdkmt_${s}_rest_run6.nii.gz" >> fc_${s}.sh

		echo "3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_${s}_rest_run1.nii.gz" >> fc_${s}.sh
		echo "3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_${s}_rest_run2.nii.gz" >> fc_${s}.sh
		echo "3dTstat -stdev -prefix s3.nii.gz NNrun3/wdkmt_${s}_rest_run3.nii.gz" >> fc_${s}.sh
		echo "3dTstat -stdev -prefix s4.nii.gz NNrun4/wdkmt_${s}_rest_run4.nii.gz" >> fc_${s}.sh
		echo "3dTstat -stdev -prefix s5.nii.gz NNrun5/wdkmt_${s}_rest_run5.nii.gz" >> fc_${s}.sh
		echo "3dTstat -stdev -prefix s6.nii.gz NNrun6/wdkmt_${s}_rest_run6.nii.gz" >> fc_${s}.sh

		echo "3dcalc -a m1.nii.gz -b s1.nii.gz -c m2.nii.gz -d s2.nii.gz -e m3.nii.gz -f s3.nii.gz -g m4.nii.gz -h s4.nii.gz -i m5.nii.gz -j s5.nii.gz -k m6.nii.gz -l s6.nii.gz -expr '((a/b)+(c/d)+(e/f)+(g/h)+(i/j)+(k/l))/6' -prefix ${s}_tsnr_mean.nii.gz" >> fc_${s}.sh

		echo "rm m*.nii.gz; rm s*.nii.gz" >> fc_${s}.sh
		#echo "rm NNrun*/*t_*" >> fc_${s}.sh
		echo "" >> fc_${s}.sh

		echo "rm ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
		echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh 
		echo "" >> fc_${s}.sh

		# connectivity
		echo "rm *corrmat*" >> fc_${s}.sh
		echo "" >> fc_${s}.sh

		echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
		echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
		echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
		echo "" >> fc_${s}.sh

		echo 'for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do' >> fc_${s}.sh
			echo "num=\$(expr \$(wc -l ${s}_Full_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fc_${s}.sh
			echo "tail -n \$num ${s}_Full_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_full_corrmat_\${p}" >> fc_${s}.sh
			echo "" >> fc_${s}.sh

			echo "num=\$(expr \$(wc -l ${s}_Right_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fc_${s}.sh
			echo "tail -n \$num ${s}_Right_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Right_corrmat_\${p}" >> fc_${s}.sh
			echo "" >> fc_${s}.sh

			echo "num=\$(expr \$(wc -l ${s}_Left_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fc_${s}.sh
			echo "tail -n \$num ${s}_Left_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Left_corrmat_\${p}" >> fc_${s}.sh
			echo "" >> fc_${s}.sh

		echo "done" >> fc_${s}.sh
		
		#graph theory
		echo "addpath(genpath('/home/despo/kaihwang/bin/'));" >> g${s}.m
		echo "addpath(genpath('/home/despo/kaihwang/matlab/'));" >> g${s}.m
		echo "[Adj, Graph] = cal_graph('${s}');" >> g${s}.m
		echo "save /home/despo/kaihwang/Rest/Graph/g_${s}.mat; exit;" >> g${s}.m

		echo "matlab -nodisplay -nosplash < /home/despo/kaihwang/bin/Thalamo/g${s}.m" >> graph_${s}.sh
		
		qsub -V -M kaihwang -l mem_free=10G -m e -e ~/tmp -o ~/tmp fc_${s}.sh
		#sleep 3.34s

done		
