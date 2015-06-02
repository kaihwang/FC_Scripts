#!/bin/bash

# script to create adj matrices using WashU's 333 ROI partition. Then submit to graph analysis. MGH Subs


WD='/home/despoB/kaihwang/Rest/Older_Controls'

for s in 1103; do

	mkdir /tmp/KH_${s}

	cd ${WD}/${s}/MNINonLinear/

	#grab list of files to concat
	rsfMRI_runs_list=(`ls rfMRI_REST*_reg_bp.nii.gz`)

	#concat the files into one run
	3dTcat -rlt++ -prefix /tmp/KH_${s}/input.nii.gz rfMRI_REST1_PA_reg_bp.nii.gz'[1dcat run1_scrub.1D]' rfMRI_REST2_PA_reg_bp.nii.gz'[1dcat run2_scrub.1D]'

	# run NetCorr
	cd /tmp/KH_${s}
	3dNetCorr -prefix ${s}_thalamocortical_corrmat -inset input.nii.gz -in_rois /home/despoB/kaihwang/Rest/ROIs/WashU297_plus_thalamus_25prob_voxels_ROIset_LPI_lfov.nii.gz

	# exract adj matrices
	num=$(expr $(wc -l ${s}_thalamocortical_corrmat_000.netcc | awk '{print $1}') - 4)
	tail -n $num ${s}_thalamocortical_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_FIX_thalamocortical_corrmat

	#num=$(expr $(wc -l ${s}_Right_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Right_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Right_Craddock700_corrmat

	#num=$(expr $(wc -l ${s}_Left_corrmat_000.netcc | awk '{print $1}') - 4)
	#tail -n $num ${s}_Left_corrmat_000.netcc > /home/despoB/kaihwang/Rest/AdjMatrices/t${s}_Left_Craddock700_corrmat
		
	#graph theory
	echo "addpath(genpath('/home/despoB/kaihwang/bin/'));" >> thalamocorticalROIg${s}.m
	echo "addpath(genpath('/home/despoB/kaihwang/matlab/'));" >> thalamocorticalROIg${s}.m
	echo "[Adj, Graph] = cal_thalamo_cortical_graph('${s}');" >> thalamocorticalROIg${s}.m
	echo "save /home/despoB/kaihwang/Rest/Thalamic_parcel/g_${s}.mat; exit;" >> thalamocorticalROIg${s}.m

	matlab -nodisplay -nosplash < /tmp/KH_${s}/thalamocorticalROIg${s}.m

	cd ${WD}/${s}
	rm -rf /tmp/KH_${s}/

done
