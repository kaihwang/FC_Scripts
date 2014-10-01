#!/bin/sh

#script to calculate ROIxROI connectivity matrices. Using AFNI

# tha patients
for s in 128 162 163 168 176; do
	
	echo "cd /home/despo/kaihwang/Rest/Lesion/${s}/Rest" >> fc_${s}.sh
	echo "" >> fc_${s}.sh
	
	echo "rm ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh 
	echo "" >> fc_${s}.sh
	
	# connectivity
	echo "rm *corrmat*" >> fc_${s}.sh
	echo "" >> fc_${s}.sh
	
	echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_right_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_left_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	echo "" >> fc_${s}.sh
	
	echo 'for p in $(seq 21 42); do' >> fc_${s}.sh
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
	#. fc_${s}.sh
	
	#. fc_${s}.sh > ~/tmp/fc_${s}_NetCorr.log 2>&1 &
	#qsub -V -e ~/tmp -o ~/tmp fc_${s}.sh
	
done


# BG patients
#for s in b116 b117 b120 b121 b122 b138 b143 b153; do

#	echo "cd /home/despo/kaihwang/Rest/BG/${s}/Rest" >> fc_${s}.sh
#	echo "" >> fc_${s}.sh
	
#	echo "rm ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
#	echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-20)' -prefix ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh 
#	echo "" >> fc_${s}.sh
	
#	# connectivity
#	echo "rm *corrmat*" >> fc_${s}.sh
#	echo "" >> fc_${s}.sh
	
#	echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
#	echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_right_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
#	echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_left_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
#	echo "" >> fc_${s}.sh
	
#	echo 'for p in $(seq 21 42); do' >> fc_${s}.sh
#		echo "num=\$(expr \$(wc -l ${s}_Full_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fc_${s}.sh
#		echo "tail -n \$num ${s}_Full_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/b${s}_full_corrmat_\${p}" >> fc_${s}.sh
#		echo "" >> fc_${s}.sh
		
#		echo "num=\$(expr \$(wc -l ${s}_Right_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fc_${s}.sh
#		echo "tail -n \$num ${s}_Right_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/b${s}_Right_corrmat_\${p}" >> fc_${s}.sh
#		echo "" >> fc_${s}.sh
		
#		echo "num=\$(expr \$(wc -l ${s}_Left_corrmat_0\${p}.netcc | awk '{print \$1}') - 4)" >> fc_${s}.sh
#		echo "tail -n \$num ${s}_Left_corrmat_0\${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/b${s}_Left_corrmat_\${p}" >> fc_${s}.sh
#		echo "" >> fc_${s}.sh
		
#	echo "done" >> fc_${s}.sh
	
#	qsub -V -e ~/tmp -o ~/tmp fc_${s}.sh

#done


# Control
for s in 214; do
	
	echo "cd /home/despo/kaihwang/Rest/Control/${s}/Rest" >> fc_${s}.sh
	echo "" >> fc_${s}.sh
	
	#echo "rm ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	#echo "3dcalc -a ${s}_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh 
	#echo "" >> fc_${s}.sh
	
	# connectivity
	#echo "rm *corrmat*" >> fc_${s}.sh
	#echo "" >> fc_${s}.sh
	
	#echo "3dNetCorr -prefix ${s}_Full_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	#echo "3dNetCorr -prefix ${s}_Right_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_right_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	#echo "3dNetCorr -prefix ${s}_Left_corrmat -inset ${s}-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/craddock_resample_left_masked.nii.gz -mask ${s}_tsnr_mask.nii.gz" >> fc_${s}.sh
	echo "" >> fc_${s}.sh
	
	echo 'for p in $(seq 21 42); do' >> fc_${s}.sh
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
	
	. fc_${s}.sh
	#. fc_${s}.sh > ~/tmp/fc_${s}_NetCorr.log 2>&1 &
	# qsub -V -e ~/tmp -o ~/tmp fc_${s}.sh

done


#left overs
#tail -n 105 ${s}_Left_corrmat_000.netcc > /home/despo/kaihwang/Rest/AdjMatricest${s}_left_corrmat_100
#tail -n 113 ${s}_Right_corrmat_000.netcc > /home/despo/kaihwang/Rest/AdjMatricest${s}_right_corrmat_100
#tail -n 178 ${s}_Full_corrmat_000.netcc > /home/despo/kaihwang/Rest/AdjMatricest${s}_full_corrmat_100

#create SNR mask.
#rm ${s}_tsnr_mean.nii.gz
#3dMean -prefix ${s}_tsnr_mean.nii.gz ${s}-preproc-run1.tsnr+tlrc ${s}-preproc-run2.tsnr+tlrc
