#!/bin/bash

# script to submit jobs to cluster for preprocessing anatomical data.

#for lesion patients
export SUBJECTS_DIR="/home/despoB/kaihwang/Subjects"
WD='/home/despoB/kaihwang/Rest/Older_Controls'

for s in 1103; do
	
	cd ${WD}/${s}

	# Need to first run freesurfer
	dcm2nii -d N -e N -f N -i N -n Y -o . mprage/
	recon-all -i t1mprage.nii.gz -all -subjid $s
	
	#then do SUMA transformation
	cd $SUBJECTS_DIR/$s
	@SUMA_Make_Spec_FS -sid $s
	
	
	#call preprocessMPrage for normalization
	cd $SUBJECTS_DIR/$s/SUMA
	3dcopy ${s}_SurfVol+orig ${s}_SurfVol.nii.gz
	
	preprocessMprage -r MNI_2mm \
	-b "-R -S -B -f 0.05 -g -0.3" \
	-no_bias \
	-o ${s}_MNI_final.nii.gz -n ${s}_SurfVol.nii.gz
	
	#align aseg, then turn it into afni format
	fslreorient2std aseg.nii aseg_r.nii.gz
	rm aseg.nii
	
	applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=${s}_SurfVol_warpcoef.nii.gz
	
	3dcopy aseg_mni.nii.gz aseg_mni+tlrc
	3dcopy ${s}_MNI_final.nii.gz ${s}_MNI_final+tlrc
	
	#qsub a_$s.sh
done