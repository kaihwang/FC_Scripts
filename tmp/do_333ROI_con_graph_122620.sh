#!/bin/bash

# script to create adj matrices using WashU's 333 ROI partition. Then submit to graph analysis. For connectome subjects


WD='/home/despoB/kaihwang/Rest/connectome'

for s in 122620; do

	mkdir /tmp/KH_${s}

	cd ${WD}/${s}/MNINonLinear/

	#grab list of files to concat
ls
	rsfMRI_runs_list=(`ls rfMRI_REST1*_reg_bp.nii.gz`)

	#concat the files into one run
	3dTcat -rlt++ -prefix /tmp/KH_${s}/input.nii.gz ${rsfMRI_runs_list[*]}

	# run NetCorr
	cd /tmp/KH_${s}
	3dNetCorr -prefix ${s}_Full_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/WashU333_2mm.nii.gz
	#3dNetCorr -prefix ${s}_Right_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/WashU333_2mm_right.nii.gz
	#3dNetCorr -prefix ${s}_Left_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/WashU333_2mm_left.nii.gz

	# exract adj matrices
	num=$(expr $(wc -l ${s}_Full_corrmat_000.netcc | awk '{print $1}') - 4)
	tail -n $num ${s}_Full_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Full_WashU333_corrmat

	#num=$(expr $(wc -l ${s}_Right_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Full_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Right_WashU333_corrmat

	#num=$(expr $(wc -l ${s}_Left_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Full_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Left_WashU333_corrmat
		
	#graph theory
	echo "addpath(genpath('/home/despo/kaihwang/bin/'));" >> ROIg${s}.m
	echo "addpath(genpath('/home/despo/kaihwang/matlab/'));" >> ROIg${s}.m
	echo "[Adj, Graph] = cal_graph('${s}');" >> ROIg${s}.m
	echo "save /home/despo/kaihwang/Rest/Graph/g_${s}.mat; exit;" >> ROIg${s}.m

	matlab -nodisplay -nosplash < /tmp/KH_${s}/ROIg${s}.m

	cd ${WD}/${s}/MNINonLinear/
	rm -rf /tmp/KH_${s}/

done
