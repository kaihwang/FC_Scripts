#!/bin/bash

#calculate DVARs FD



#to calculate DVARS

for s in 128; do

	cd ~ #/home/despoB/kaihwang/Rest/Lesion/${s}/MNINonLinear
	for run in 1; do

		3dTcat -prefix rfMRI_REST${run}_templag.nii.gz rfMRI_REST${run}_LR_hp2000_clean.nii.gz[0] rfMRI_REST${run}_LR_hp2000_clean.nii.gz[0][0..1198]
		fslmaths rfMRI_REST${run}_LR_hp2000_clean.nii.gz -sub rfMRI_REST${run}_templag.nii.gz rfMRI_REST${run}_tempdiff.nii.gz
		3dcalc -a rfMRI_REST${run}_tempdiff.nii.gz -expr '(a^2)' -prefix rfMRI_REST${run}_DVAR_despike.nii.gz
		3dmaskave -mask rfMRI_REST${run}_DVAR_despike.nii.gz[2] -quiet rfMRI_REST${run}_DVAR_despike.nii.gz > rfMRI_REST${run}_tmp.1D
		1deval -a rfMRI_REST${run}_tmp.1D -expr 'sqrt(a)' > rfMRI_REST${run}_DVARs.1D

		rm rfMRI_REST${run}_DVAR_despike.nii.gz
		rm rfMRI_REST${run}_tmp.1D
		rm rfMRI_REST${run}_templag.nii.gz
		rm rfMRI_REST${run}_tempdiff.nii.gz

	done

done

