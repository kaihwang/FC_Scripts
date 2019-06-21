#!/bin/bash


#Subjects=$(cat /data/backed_up/shared/Tha_Lesion_Mapping/Subject_List.txt)
#NKI
for subject in $(cat /data/backed_up/shared/Tha_Lesion_Mapping/Subject_List.txt); do

	mkdir /data/backed_up/shared/Tha_Lesion_Mapping/${subject}/
	
	for mask in 0902 1105 1692 1809 1830 2092 2105 2552 2697 2781 3049 3184; do	

		3dmaskave -q -mask /home/kahwang/Tha_Lesion_Masks/${mask}_2mm.nii.gz \
			/data/backed_up/shared/NKI/${subject}/MNINonLinear/rfMRI_REST_mx_1400_ncsreg.nii.gz \
			 > /data/backed_up/shared/Tha_Lesion_Mapping/${subject}/${mask}_${subject}_TS.1D
		
		3dfim+ -input /data/backed_up/shared/NKI/${subject}/MNINonLinear/rfMRI_REST_mx_1400_ncsreg.nii.gz \
			-ideal_file /data/backed_up/shared/Tha_Lesion_Mapping/${subject}/${mask}_${subject}_TS.1D \
			-out 'Correlation' \
			-bucket /data/backed_up/shared/Tha_Lesion_Mapping/${subject}/${mask}_${subject}_TS_fit.nii.gz \


	done
done



