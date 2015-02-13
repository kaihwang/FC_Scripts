#!/bin/bash

# This is a another version of preprocessing.....!@#$@#$#@$
# The goal here is to mimic the HCP preprocessing pipeline.
# First do spatial preprocessing, then regression, then bandpass + spatial bluring.


WD='/home/despoB/kaihwang/Rest/Older_Controls'




for s in 1103; do
	cd ${WD}/${s}/

	if [ ! -d "${WD}/${s}/MNINonLinear/" ]; then
		mkdir ${WD}/${s}/MNINonLinear/
	fi

	# get the bet brain
	3dresample -oreint LPI -inset /home/despoB/kaihwang/Subjects/${s}/SUMA/brain.nii.gz \
	-prefix /home/despoB/kaihwang/Subjects/${s}/SUMA/brain_lpi.nii.gz

	# first determine the number of runs that need to be processed. Its quite annoying different subjects have different runs.
	for r in $(seq 1 1 $(ls -d rest_run* | wc -l)); do
		
		#create tmp folder to do read/write
		mkdir /tmp/KH_${s}_run${r}

		cd ${WD}/${s}/
		dcm2nii -d N -e N -f N -i N -n Y -o /tmp/KH_${s}_run${r} rest_run${r}/
		cd /tmp/KH_${s}_run${r}
		raw_nii=$(ls *.nii.gz)
		3dcopy $raw_nii input.nii.gz

		cd /tmp/KH_${s}_run${r}

		# get the TR info
		TR=$(3dinfo input.nii.gz | grep -o 'Time step = [0-9].[0-9][0-9]' | grep -o [0-9].[0-9][0-9])

		# michael's functional preprocessing script for spatial preprocessing
		preprocessFunctional -4d input.nii.gz \
		-tr ${TR} \
		-mprage_bet /home/despoB/kaihwang/Subjects/${s}/SUMA/brain_lpi.nii.gz \
		-threshold 98_2 \
		-rescaling_method 10000_globalmedian \
		-template_brain MNI_2mm \
		-func_struc_dof bbr \
		-warp_interpolation spline \
		-constrain_to_template y \
		-motion_sinc y \
		-st_first \
		-cleanup \
		-log preproc \
		-no_hp \
		-no_smooth \
		-slice_acquisition interleaved \
		-warpcoef /home/despoB/kaihwang/Subjects/${s}/SUMA/${s}_SurfVol_warpcoef.nii.gz \
		-startover

		# some of AFNI's program doesn't like NIFTI... so copy to afni BRIK/HEAD format
		3dcopy nwkmt_input.nii.gz nwkmt_input
		3dcopy /home/despoB/kaihwang/Subjects/${s}/SUMA/aseg_mni.nii.gz /tmp/KH_${s}_run${r}/aseg_mni
		
		# concat motion regressors and its deriv
		1d_tool.py -infile motion.par -derivative -write motion.deriv.1D
		1dcat motion.par motion.deriv.1D > mopar.1D


		# local WM + motion parameters regression.
		@ANATICOR \
		-ts nwkmt_input+tlrc \
		-polort 3 \
		-aseg aseg_mni+tlrc \
		-motion mopar.1D \
		-radius 30 \
		-prefix input_reg \
		-view +tlrc
		
		# bandpass filtering
		3dBandpass \
		-nodetrend -automask \
		-blur 5 -band 0.009 0.08 \
		-prefix ${WD}/${s}/MNINonLinear/rfMRI_REST${r}_PA_reg_bp.nii.gz \
		-input input_reg+tlrc 

		cp mopar.1D ${WD}/${s}/MNINonLinear/rfMRI_REST${r}_PA_mopar.1D 
		
		cd ${WD}/${s}/MNINonLinear/
		rm -rf /tmp/KH_${s}_run${r} 
	done
	

done





