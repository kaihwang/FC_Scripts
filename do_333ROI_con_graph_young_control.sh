#!/bin/bash
# script to create adj matrices using WashU's 333 ROI partition. Then submit to graph analysis.


WD='/home/despoB/kaihwang/Rest/Controls'

for s in 114; do

	mkdir /tmp/KH_${s}

	cd ${WD}/${s}/MNINonLinear/

	#grab list of files to concat
	#rsfMRI_runs_list=(`ls rfMRI_REST*_reg_bp.nii.gz`)

	#concat the files into one run
	3dTcat -rlt++ -prefix /tmp/KH_${s}/input.nii.gz rfMRI_REST1_PA_reg_bp.nii.gz'[1dcat run1_scrub.1D]' rfMRI_REST2_PA_reg_bp.nii.gz'[1dcat run2_scrub.1D]'

	# run NetCorr
	cd /tmp/KH_${s}
	3dNetCorr -prefix ${s}_Full_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/WashU333_2mm_overlapMasked_clust.nii.gz
	#3dNetCorr -prefix ${s}_Right_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/Craddock700_Cortical_2mm_R_largerFOV.nii.gz
	#3dNetCorr -prefix ${s}_Left_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/Craddock700_Cortical_2mm_L_largerFOV.nii.gz

	# exract adj matrices
	num=$(expr $(wc -l ${s}_Full_corrmat_000.netcc | awk '{print $1}') - 4)
	tail -n $num ${s}_Full_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Full_WashU333_corrmat

	#num=$(expr $(wc -l ${s}_Right_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Right_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Right_Craddock700_corrmat

	#num=$(expr $(wc -l ${s}_Left_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Left_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Left_Craddock700_corrmat
		
	#graph theory
	echo "addpath(genpath('/home/despoB/kaihwang/bin/'));" >> /home/despoB/kaihwang/bin/Thalamo/tmp/ROIg${s}.m
	echo "addpath(genpath('/home/despoB/kaihwang/matlab/'));" >> /home/despoB/kaihwang/bin/Thalamo/tmp/ROIg${s}.m
	echo "[Adj, Graph] = cal_graph_setCI('${s}');" >> /home/despoB/kaihwang/bin/Thalamo/tmp/ROIg${s}.m
	echo "save /home/despoB/kaihwang/Rest/Graph/gsetCI_${s}.mat; exit;" >> /home/despoB/kaihwang/bin/Thalamo/tmp/ROIg${s}.m

	matlab -nodisplay -nosplash < /home/despoB/kaihwang/bin/Thalamo/tmp/ROIg${s}.m

	cd ${WD}/${s}/MNINonLinear/
	rm -rf /tmp/KH_${s}/

done
