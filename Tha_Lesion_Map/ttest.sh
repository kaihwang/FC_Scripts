#!/bin/bash


for mask in 0902 1105 1692 1809 1830 2092 2105 2552 2697 2781 3049 3184; do	

	3dttest++ \
	-setA "/data/backed_up/shared/Tha_Lesion_Mapping/0*/${mask}_*TS_fit.nii.gz" \
	-prefix /data/backed_up/shared/Tha_Lesion_Mapping/NKI_ttest_${mask}.nii.gz

done