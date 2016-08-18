#!/bin/bash
# script to create adj matrices and output TS for HCP task data


WD='/home/despoB/connectome-data'

for s in 100307; do

	mkdir /tmp/KH_${s}/

	for condition in LANGUAGE_LR LANGUAGE_RL WM_LR WM_RL RELATIONAL_LR RELATIONAL_RL; do
		#cd ${WD}/${s}/tfMRI_${condition}

		if [ -e ${WD}/${s}/tfMRI_${condition}/tfMRI_${condition}_reg.nii.gz ]; then
			
			for roi in Gordon_333_cortical; do    

				3dNetCorr \
				-inset ${WD}/${s}/tfMRI_${condition}/tfMRI_${condition}_reg.nii.gz \
				-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
				-ts_out \
				-prefix /tmp/KH_${s}/${s}_${condition}_${roi}	

				mv /tmp/KH_${s}/${s}_${condition}_${roi}_000.netts /home/despoB/connectome-thalamus/NotBackedUp/TS/

			done

			for roi in Thalamus_WTA Morel; do

				3dNetCorr \
				-inset ${WD}/${s}/tfMRI_${condition}/tfMRI_${condition}_reg.nii.gz \
				-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
				-ts_out \
				-prefix /tmp/KH_${s}/${s}_${condition}_${roi}

				mv /tmp/KH_${s}/${s}_${condition}_${roi}_000.netts /home/despoB/connectome-thalamus/NotBackedUp/TS/

				echo "${s} ${condition} ${roi}" | python /home/despoB/kaihwang/bin/FC_Scripts/cal_pcorr.py

			done
		fi
	done	
	rm -rf /tmp/KH_${s}/
done