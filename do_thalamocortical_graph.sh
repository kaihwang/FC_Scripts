#!/bin/bash

# script to create adj matrices using WashU's 333 ROI + thalamic voxel partition. Then submit to graph analysis. For connectome subjects


WD='/home/despoB/kaihwang/Rest/connectome'

for s in 100307; do

	mkdir /tmp/KH_${s}_thalamocortical

	cd ${WD}/${s}/MNINonLinear/

	#grab list of files to concat
	rsfMRI_runs_list=(`ls rfMRI_REST1*_reg_bp.nii.gz`)

	#concat the files into one run
	3dTcat -rlt++ -prefix /tmp/KH_${s}_thalamocortical/input.nii.gz ${rsfMRI_runs_list[*]}

	# run NetCorr
	cd /tmp/KH_${s}_thalamocortical
	3dNetCorr -prefix ${s}_thalamocortical_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/WashU333_plus_thalamus_voxels_ROIset_RPI.nii.gz
	#3dNetCorr -prefix ${s}_Right_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/Craddock700_Cortical_R_2mm.nii.gz
	#3dNetCorr -prefix ${s}_Left_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/Craddock700_Cortical_L_2mm.nii.gz

	# exract adj matrices
	num=$(expr $(wc -l ${s}_thalamocortical_corrmat_000.netcc | awk '{print $1}') - 4)
	tail -n $num ${s}_thalamocortical_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_thalamocortical_corrmat

	#num=$(expr $(wc -l ${s}_Right_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Right_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Right_Craddock700_corrmat

	#num=$(expr $(wc -l ${s}_Left_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Left_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Left_Craddock700_corrmat
		
	#graph theory
	echo "addpath(genpath('/home/despoB/kaihwang/bin/'));" >> thalamocorticalROIg${s}.m
	echo "addpath(genpath('/home/despoB/kaihwang/matlab/'));" >> thalamocorticalROIg${s}.m
	echo "[Adj, Graph] = cal_thalamo_cortical_graph('${s}');" >> thalamocorticalROIg${s}.m
	echo "save /home/despo/kaihwang/Rest/Thalamic_parcel/g_${s}.mat; exit;" >> thalamocorticalROIg${s}.m

	matlab -nodisplay -nosplash < /tmp/KH_${s}_thalamocortical/thalamocorticalROIg${s}.m

	cd ${WD}/${s}/MNINonLinear/
	rm -rf /tmp/KH_${s}/_thalamocortical

done
