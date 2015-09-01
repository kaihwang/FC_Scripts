#script to regressout gm signal near the thalamus. residuals will be used for later thalamocortical connectivity
#NKI data
WD='/home/despoB/connectome-thalamus/NKI'

for s in 0102826_session_1; do

	cd ${WD}/${s}/MNINonLinear

		for run in _mx_1400 _mx_645 _std_2500; do

			3dmaskave -quiet \
			-mask /home/despoB/connectome-thalamus/ROIs/Thalamus_surround_cortical_mask.nii.gz \
			${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz > ncs_${run}.1D

			3dTproject -input ${WD}/${s}/MNINonLinear/rfMRI_REST${run}.nii.gz \
			-prefix ${WD}/${s}/MNINonLinear/rfMRI_REST${run}_ncsreg.nii.gz \
			-ort ${WD}/${s}/MNINonLinear/ncs_${run}.1D \
			-automask 
		done

done