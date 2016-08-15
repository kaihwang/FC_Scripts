#!/bin/bash
# script to create adj matrices, or spit out the timeseries file


WD='/home/despoB/kaihwang/Rest/Tha_patients'

cd ${WD}


for s in 128 163 168; do

	mkdir /tmp/KH_${s}/
	cd ${WD}/${s}/MNINonLinear


	## concat
	#if [ -e ${WD}/${s}/MNINonLinear/rfMRI_REST2.nii.gz ]; then
	#	3dTcat -prefix rfMRI_REST.nii.gz rfMRI_REST1_PA_reg_bp.nii.gz rfMRI_REST2_PA_reg_bp.nii.gz
	#else
	#	3dcopy rfMRI_REST1_PA_reg_bp.nii.gz rfMRI_REST.nii.gz
	#
	#fi
	
	# 3dresample -master /home/despoB/connectome-thalamus/ROIs/Craddock_300_cortical.nii.gz \
	# -inset ${WD}/${s}/Rest/${s}-rest-preproc-cen.nii.gz \
	# -prefix ${WD}/${s}/MNINonLinear/rfMRI_REST_RPI.nii.gz

	#rm ${WD}/${s}/MNINonLinear/rfMRI_REST.nii.gz
	#
	#Craddock_300_cortical Craddock_900_cortical
	for roi in Gordon_333_cortical; do

		3dNetCorr \
		-inset ${WD}/${s}/MNINonLinear/rfMRI_REST_RPI.nii.gz \
		-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
		-prefix /tmp/KH_${s}/Adj_${roi}

		num=$(expr $(wc -l /tmp/KH_${s}/Adj_${roi}_000.netcc | awk '{print $1}') - 6)
		tail -n $num /tmp/KH_${s}/Adj_${roi}_000.netcc > /tmp/KH_${s}/Tha_${s}_${roi}_corrmat

		mv /tmp/KH_${s}/Tha_${s}_${roi}_corrmat /home/despoB/connectome-thalamus/NotBackedUp/ParMatrices
	done

	rm -rf /tmp/KH_${s}/
done
