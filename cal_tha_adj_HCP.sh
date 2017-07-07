#!/bin/bash
# script to create adj matrices and output TS for HCP task data


WD='/home/despoB/connectome-data'

for s in 100206; do

	#mkdir /tmp/KH_${s}/

	for condition in EMOTION_LR EMOTION_RL GAMBLING_LR GAMBLING_RL MOTOR_LR MOTOR_RL SOCIAL_LR SOCIAL_RL LANGUAGE_LR LANGUAGE_RL WM_LR WM_RL RELATIONAL_LR RELATIONAL_RL; do
		#cd ${WD}/${s}/tfMRI_${condition}

		if [ -e ${WD}/${s}/tfMRI_${condition}/tfMRI_${condition}_reg.nii.gz ]; then
			
			for roi in Morel_plus_Yeo400; do    #Gordon_plus_Morel Gordon_plus_Thalamus_WTA


				3dNetCorr \
				-inset ${WD}/${s}/tfMRI_${condition}/tfMRI_${condition}_reg.nii.gz \
				-in_rois /home/despoB/kaihwang/Rest/ThaGate/ROIs/${roi}.nii.gz -ts_out \
				-prefix /home/despoB/kaihwang/Rest/ThaGate/NotBackedUp/${s}_${roi}_${condition}

				#3dNetCorr \
				#-inset ${WD}/${s}/tfMRI_${condition}/tfMRI_${condition}_reg.nii.gz \
				#-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
				#-prefix /tmp/KH_${s}/${s}_${condition}_${roi}	

				#num=$(expr $(wc -l /tmp/KH_${s}/${s}_${condition}_${roi}_000.netcc | awk '{print $1}') - 6)
				#tail -n $num /tmp/KH_${s}/${s}_${condition}_${roi}_000.netcc > /tmp/KH_${s}/${s}_${condition}_${roi}.corrmat
				#mv /tmp/KH_${s}/${s}_${condition}_${roi}.corrmat /home/despoB/connectome-thalamus/NotBackedUp/HCP_Matrices/ 
				

			done
		fi
	done

	# for condition in REST1_LR REST1_RL REST2_RL REST2_LR; do
		
	# 	if [ -e ${WD}/${s}/rfMRI_${condition}/rfMRI_${condition}_hp2000_clean_wbsreg.nii.gz ]; then
			
	# 		for roi in Gordon_plus_Morel Gordon_plus_Thalamus_WTA; do    

	# 			3dNetCorr \
	# 			-inset ${WD}/${s}/rfMRI_${condition}/rfMRI_${condition}_hp2000_clean_wbsreg.nii.gz \
	# 			-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
	# 			-prefix /tmp/KH_${s}/${s}_${condition}_${roi}	

	# 			num=$(expr $(wc -l /tmp/KH_${s}/${s}_${condition}_${roi}_000.netcc | awk '{print $1}') - 6)
	# 			tail -n $num /tmp/KH_${s}/${s}_${condition}_${roi}_000.netcc > /tmp/KH_${s}/${s}_${condition}_${roi}.corrmat
	# 			mv /tmp/KH_${s}/${s}_${condition}_${roi}.corrmat /home/despoB/connectome-thalamus/NotBackedUp/HCP_Matrices/ 
				
	# 		done

	# 	fi
	# done	
	# rm -rf /tmp/KH_${s}/
done