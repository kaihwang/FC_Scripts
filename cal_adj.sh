#!/bin/bash
# script to create adj matrices, here this is for partial regression


WD='/home/despoB/connectome-thalamus/NKI'

cd ${WD}


for s in 0102826_session_1; do

	mkdir /tmp/KH_${s}/
	cd ${WD}/${s}/MNINonLinear

	for run in _mx_1400 _mx_645; do

		#Crotical ROIs + Thalamsu (lobe), partial corr
		# 3dNetCorr \
		# -inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		# -in_rois /home/despoB/connectome-thalamus/ROIs/Cortex_plus_thalamus_ROIs.nii.gz \
		# -part_corr \
		# -prefix Adj_cortex_thalamus_${run}_par

		#Cortex_plus_thalamus_ROIs
		#
		# for roi in Cortical_CI_plus_thalamus; do

		# 	3dNetCorr \
		# 	-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}_ncsreg.nii.gz \
		# 	-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
		# 	-prefix /tmp/KH_${s}/Adj_${roi}_${run}_ncsreg

		# 	num=$(expr $(wc -l /tmp/KH_${s}/Adj_${roi}_${run}_ncsreg_000.netcc | awk '{print $1}') - 6)
		# 	tail -n $num /tmp/KH_${s}/Adj_${roi}_${run}_ncsreg_000.netcc > /tmp/KH_${s}/NKI_${s}_${roi}_${run}_ncsreg_corrmat
		# 	mv /tmp/KH_${s}/NKI_${s}_${roi}_${run}_ncsreg_corrmat /home/despoB/connectome-thalamus/AdjMatrices/
		# done


		# for roi in Craddock_300_cortical Craddock_900_cortical; do

		# 	3dNetCorr \
		# 	-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
		# 	-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
		# 	-prefix /tmp/KH_${s}/Adj_${roi}_${run}

		# 	num=$(expr $(wc -l /tmp/KH_${s}/Adj_${roi}_${run}_000.netcc | awk '{print $1}') - 6)
		# 	tail -n $num /tmp/KH_${s}/Adj_${roi}_${run}_000.netcc > /tmp/KH_${s}/NKI_${s}_${roi}_${run}_corrmat

		# 	mv /tmp/KH_${s}/NKI_${s}_${roi}_${run}_corrmat /home/despoB/connectome-thalamus/AdjMatrices/
		# done


		# Thalamus_plus_cortical_ROIs Thalamus_plus_cortical_network_ROIs Thalamus_plus_cortex_ROIs
		for template in Thalamus_plus_cortical_network_ROIs Thalamus_plus_cortex_ROIs; do

		echo -n "" > /home/despoB/connectome-thalamus/NotBackedUp/ParMatrices/NKI_${s}_${run}_${template}_partial_mat
			for i in $(seq 1001 4549); do
				3dNetCorr \
				-inset ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
				-in_rois /home/despoB/connectome-thalamus/ROIs/${template}/Thalamus_vox${i}_plus_cortical_ROI.nii.gz \
				-part_corr -prefix /tmp/KH_${s}/test 

				num=$(expr $((($(cat /tmp/KH_${s}/test_000.netcc | wc -l)-8)/3 +2)))
				cat /tmp/KH_${s}/test_000.netcc  | tail -n ${num} | head -n 1 >> /home/despoB/connectome-thalamus/NotBackedUp/ParMatrices/NKI_${s}_${run}_${template}_partial_mat

			done	
		done


	done	

	rm -rf /tmp/KH_${s}/
done
