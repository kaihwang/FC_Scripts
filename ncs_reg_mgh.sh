#script to regressout gm signal near the thalamus. residuals will be used for later thalamocortical connectivity
#MGH data
WD='/home/despoB/connectome-thalamus/MGH'

for s in Sub0001_Ses1; do

	cd ${WD}/${s}/MNINonLinear

		for run in 1 2; do

			3dmaskave -quiet \
			-mask /home/despoB/connectome-thalamus/ROIs/Thalamus_surround_cortical_mask.nii.gz \
			${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz > ncs_${run}.1D

			3dTproject -input ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
			-prefix ${WD}/${s}/MNINonLinear/rfMRI_REST${run}_ncsreg.nii.gz \
			-ort ${WD}/${s}/MNINonLinear/ncs_${run}.1D \
			-automask 
		done

done