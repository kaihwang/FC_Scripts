#!/bin/bash
# compare NKI data and connectome data tsnr


WD='/home/despoB/kaihwang/Compare_TSNR'
NKI_Path='/home/despoB/mb3152/data/nki_data/preprocessed/pipeline_pipeline'

# cd $NKI_Path
# for Subject in $(ls -d */ | sed -e "s/\///g"); do
# 	cd ${NKI_Path}/${Subject}/motion_correct_to_standard/

# 	for Sequence in $(ls -d */ | sed -e "s/\///g"); do
# 		cd ${NKI_Path}/${Subject}/motion_correct_to_standard/${Sequence}

# 		ln -s ${NKI_Path}/${Subject}/motion_correct_to_standard/${Sequence}/rest_calc_tshift_resample_volreg_antswarp.nii.gz \
# 		${WD}/${Subject}_${Sequence}.nii.gz

# 		cd ${WD}
# 		3dTstat -nzmean -prefix ${Subject}_${Sequence}_Tmean.nii.gz ${Subject}_${Sequence}.nii.gz
# 		3dTstat -stdev -prefix ${Subject}_${Sequence}_Tstd.nii.gz ${Subject}_${Sequence}.nii.gz
# 		3dcalc -a ${Subject}_${Sequence}_Tmean.nii.gz -b ${Subject}_${Sequence}_Tstd.nii.gz -expr 'a/b' -prefix ${Subject}_${Sequence}_TSNR.nii.gz
# 	done
# done

Connectome_Path='/home/despoB/connectome-thalamus/connectome'

cd ${Connectome_Path}
for Subject in 100307; do #$(cat list_of_complete_subjects)
	
	cd ${Connectome_Path}/${Subject}/MNINonLinear
	
	# $(ls -d *REST*.nii.gz | sed -e "s/\.nii.gz//g")

	for Sequence in rfMRI_REST1_LR rfMRI_REST1_RL rfMRI_REST2_LR rfMRI_REST2_RL; do
		cd ${Connectome_Path}/${Subject}/MNINonLinear
		ln -s ${Connectome_Path}/${Subject}/MNINonLinear/${Sequence}_hp2000_clean_wbsreg.nii.gz ${WD}/${Subject}_${Sequence}_FIX.nii.gz

		cd ${WD}
		3dTstat -nzmean -prefix ${Subject}_${Sequence}_Tmean_FIX.nii.gz ${Subject}_${Sequence}_FIX.nii.gz
		3dTstat -stdev -prefix ${Subject}_${Sequence}_Tstd_FIX.nii.gz ${Subject}_${Sequence}_FIX.nii.gz
		3dcalc -a ${Subject}_${Sequence}_Tmean_FIX.nii.gz -b ${Subject}_${Sequence}_Tstd_FIX.nii.gz -expr 'a/b' -prefix ${Subject}_${Sequence}_TSNR_FIX.nii.gz

	done
done
