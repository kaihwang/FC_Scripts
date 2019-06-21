#!/bin/bash

#HCP
cd /data/not_backed_up/shared/HCP

#Subjects=$(cat /data/backed_up/shared/Tha_Lesion_Mapping/HCP_Subjects)

for subject in $(cat /data/backed_up/shared/Tha_Lesion_Mapping/HCP_Subjects); do
	mkdir /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/

	3dTcat -prefix /home/kahwang/tmp/ct.nii.gz -rlt \
		/data/not_backed_up/shared/HCP/100307/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_hp2000_clean.nii.gz[100..1199] \
		/data/not_backed_up/shared/HCP/100307/MNINonLinear/Results/rfMRI_REST1_RL/rfMRI_REST1_RL_hp2000_clean.nii.gz[100..1199] \
		/data/not_backed_up/shared/HCP/100307/MNINonLinear/Results/rfMRI_REST2_LR/rfMRI_REST2_LR_hp2000_clean.nii.gz[100..1199] \
		/data/not_backed_up/shared/HCP/100307/MNINonLinear/Results/rfMRI_REST2_RL/rfMRI_REST2_RL_hp2000_clean.nii.gz[100..1199]

	3dmaskave -q -mask /data/backed_up/shared/Tha_Lesion_Mapping/MNI_brainamsk_2mm.nii.gz /home/kahwang/tmp/ct.nii.gz > /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/wbs.1D

	3dTproject -prefix /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/rest.nii.gz \
	-bandpass 0.009 9999 -input /home/kahwang/tmp/ct.nii.gz

	3dTproject -prefix /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/rest_gsr.nii.gz \
	-ort /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/wbs.1D \
	-bandpass 0.009 9999 -input /home/kahwang/tmp/ct.nii.gz

	for mask in 0902 1105 1692 1809 1830 2092 2105 2552 2697 2781 3049 3184; do

		3dmaskave -q -mask /home/kahwang/Tha_Lesion_Masks/${mask}_2mm.nii.gz \
		/data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/rest.nii.gz > /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/tha_ts.1D

		3dmaskave -q -mask /home/kahwang/Tha_Lesion_Masks/${mask}_2mm.nii.gz \
		/data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/rest_gsr.nii.gz > /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/tha_ts_gsr.1D

		3dfim+ -input /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/rest.nii.gz \
		-ideal_file /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/tha_ts.1D \
		-out 'Correlation' \
		-bucket /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/${mask}_${subject}_TS_fit.nii.gz \

		3dfim+ -input /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/rest_gsr.nii.gz \
		-ideal_file /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/tha_ts_gsr.1D \
		-out 'Correlation' \
		-bucket /data/backed_up/shared/Tha_Lesion_Mapping/HCP_${subject}/${mask}_${subject}_TSGSR_fit.nii.gz \

	done

	rm /home/kahwang/tmp/ct.nii.gz

done


