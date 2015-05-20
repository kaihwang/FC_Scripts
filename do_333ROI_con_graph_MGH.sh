#!/bin/bash

# script to create adj matrices using WashU's 333 ROI partition. Then submit to graph analysis. MGH Subs


WD='/home/despoB/connectome-thalamus/MGH/'

for s in Sub0001_Ses1; do

	#mkdir /tmp/KH_${s}

	cd /home/despoB/kaihwang/Rest/AdjMatrices

	#grab list of files to concat
	#rsfMRI_runs_list=(`ls run*/gbreg*/*.nii.gz`)

	#concat the files into one run
	#3dTcat -rlt++ -prefix /tmp/KH_${s}/input.nii.gz ${rsfMRI_runs_list[*]}

	# run NetCorr
	#cd /tmp/KH_${s}
	#3dNetCorr -prefix ${s}_thalamocortical_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/WashU297_plus_thalamus_25prob_voxels_ROIset_RPI.nii.gz
	#3dNetCorr -prefix ${s}_Right_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/Craddock700_Cortical_R_2mm.nii.gz
	#3dNetCorr -prefix ${s}_Left_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/Craddock700_Cortical_L_2mm.nii.gz

	# exract adj matrices
	#num=$(expr $(wc -l ${s}_thalamocortical_corrmat_000.netcc | awk '{print $1}') - 4)
	head -n 297 /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_FIX_thalamocortical_corrmat > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Full_WashU333_corrmat

	#num=$(expr $(wc -l ${s}_Right_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Right_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Right_Craddock700_corrmat

	#num=$(expr $(wc -l ${s}_Left_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Left_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Left_Craddock700_corrmat
		
	#graph theory
	echo "addpath(genpath('/home/despoB/kaihwang/bin/'));" >> /home/despoB/kaihwang/tmp/ROIg${s}.m
	echo "addpath(genpath('/home/despoB/kaihwang/matlab/'));" >> /home/despoB/kaihwang/tmp/ROIg${s}.m
	echo "[Adj, Graph] = cal_graph_setCI('${s}');" >> /home/despoB/kaihwang/tmp/ROIg${s}.m
	echo "save /home/despoB/kaihwang/Rest/Graph/gsetCI_${s}.mat; exit;" >> /home/despoB/kaihwang/tmp/ROIg${s}.m

	matlab -nodisplay -nosplash < /home/despoB/kaihwang/tmp/ROIg${s}.m


done
