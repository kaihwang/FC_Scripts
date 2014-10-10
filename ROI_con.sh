#!/bin/sh

#script to calculate ROIxROI connectivity matrices. Using AFNI

# tha patients
for s in 128 162 163 168 176; do
	
	echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo "rm ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh 
	echo "" >> ROIfc_${s}.sh
	
	# connectivity
	echo "rm *corrmat*" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo 'for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do' >> ROIfc_${s}.sh
		echo "num=\$(expr \$(wc -l ${s}_Full_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Full_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_full_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
		echo "num=\$(expr \$(wc -l ${s}_Right_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Right_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Right_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
		echo "num=\$(expr \$(wc -l ${s}_Left_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Left_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Left_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
	echo "done" >> ROIfc_${s}.sh
	#. ROIfc_${s}.sh
	
	#. ROIfc_${s}.sh > ~/tmp/fc_${s}_NetCorr.log 2>&1 &
	
	#graph theory
	echo "addpath(genpath('/home/despo/kaihwang/bin/'));" >> ROIg${s}.m
	echo "addpath(genpath('/home/despo/kaihwang/matlab/'));" >> ROIg${s}.m
	echo "[Adj, Graph] = cal_graph('${s}');" >> ROIg${s}.m
	echo "save /home/despo/kaihwang/Rest/Graph/g_${s}.mat; exit;" >> ROIg${s}.m

	echo "matlab -nodisplay -nosplash < /home/despo/kaihwang/bin/Thalamo/ROIg${s}.m" >> ROIfc_${s}.sh
	
	#qsub -V -M kaihwang -e ~/tmp -o ~/tmp ROIfc_${s}.sh
	
done


# BG patients
for s in b116 b117 b120 b121 b122 b138 b143 b153; do

	echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo "rm ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh 
	echo "" >> ROIfc_${s}.sh
	
#	# connectivity
	echo "rm *corrmat*" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo 'for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do' >> ROIfc_${s}.sh
		echo "num=\$(expr \$(wc -l ${s}_Full_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Full_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_full_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
		echo "num=\$(expr \$(wc -l ${s}_Right_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Right_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Right_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
		echo "num=\$(expr \$(wc -l ${s}_Left_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Left_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Left_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
	echo "done" >> ROIfc_${s}.sh
	
	#qsub -V -e ~/tmp -o ~/tmp ROIfc_${s}.sh

done


# Control
for s in 214; do
	
	echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo "rm ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh 
	echo "" >> ROIfc_${s}.sh
	
	# connectivity
	echo "rm *corrmat*" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> ROIfc_${s}.sh
	echo "" >> ROIfc_${s}.sh
	
	echo 'for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do' >> ROIfc_${s}.sh
		echo "num=\$(expr \$(wc -l ${s}_Full_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Full_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_full_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
		echo "num=\$(expr \$(wc -l ${s}_Right_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Right_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Right_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
		echo "num=\$(expr \$(wc -l ${s}_Left_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> ROIfc_${s}.sh
		echo "tail -n \$num ${s}_Left_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t${s}_Left_corrmat_\${p}" >> ROIfc_${s}.sh
		echo "" >> ROIfc_${s}.sh
		
	echo "done" >> ROIfc_${s}.sh
	
	#graph theory
	echo "addpath(genpath('/home/despo/kaihwang/bin/'));" >> ROIg${s}.m
	echo "addpath(genpath('/home/despo/kaihwang/matlab/'));" >> ROIg${s}.m
	echo "[Adj, Graph] = cal_graph('${s}');" >> ROIg${s}.m
	echo "save /home/despo/kaihwang/Rest/Graph/g_${s}.mat; exit;" >> ROIg${s}.m

	echo "matlab -nodisplay -nosplash < /home/despo/kaihwang/bin/Thalamo/ROIg${s}.m" >> ROIfc_${s}.sh
	
#	. ROIfc_${s}.sh
	#. ROIfc_${s}.sh > ~/tmp/fc_${s}_NetCorr.log 2>&1 &
	#qsub -M kaihwang -V -e ~/tmp -o ~/tmp ROIfc_${s}.sh

done


#left overs
#tail -n 105 ${s}_Left_corrmat_000.netcc > /home/despo/kaihwang/Rest/AdjMatricest${s}_left_corrmat_100
#tail -n 113 ${s}_Right_corrmat_000.netcc > /home/despo/kaihwang/Rest/AdjMatricest${s}_right_corrmat_100
#tail -n 178 ${s}_Full_corrmat_000.netcc > /home/despo/kaihwang/Rest/AdjMatricest${s}_full_corrmat_100

#create SNR mask.
#rm ${s}_tsnr_mean.nii.gz
#3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc
