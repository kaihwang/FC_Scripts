#!/bin/sh

# script to submit jobs to cluster for preprocessing anatomical data.

#for lesion patients
for s in 128 162 163 168; do
	
	
	echo ". /etc/bashrc" >> a_$s.sh
	echo ". ~/.bashrc" >> a_$s.sh
	
	# Need to first run freesurfer
	#echo "recon-all -i ~/Lesion/$s/$s-T1.nii.gz -all -subjid $s" >> a_$s.sh
	
	#then do SUMA transformation
	echo 'cd $SUBJECTS_DIR/'$s'' >> a_$s.sh
	echo "@SUMA_Make_Spec_FS -sid $s" >> a_$s.sh
	
	
	#call preprocessMPrage for normalization
	echo 'cd $SUBJECTS_DIR/'$s/SUMA'' >> a_$s.sh
	echo "3dcopy ${s}_SurfVol+orig ${s}_SurfVol.nii.gz" >> a_$s.sh
	
	echo "preprocessMprage -r MNI_2mm \\
	-b \"-R -f 0.2 -g -0.2\" \\
	-o ${s}_MNI_final.nii.gz -n ${s}_SurfVol.nii.gz" >> a_$s.sh
	
	#align aseg, then turn it into afni format
	echo "fslreorient2std aseg.nii aseg_r.nii.gz" >> a_$s.sh
	echo "rm aseg.nii" >> a_$s.sh
	
	echo "applywarp -i aseg_r.nii.gz \\
	-r template_brain.nii -o aseg_mni.nii.gz \\
	--warp=${s}_SurfVol_warpcoef.nii.gz" >> a_$s.sh
	
	echo "3dcopy aseg_mni.nii.gz aseg_mni+tlrc" >> a_$s.sh
	echo "3dcopy ${s}_MNI_final.nii.gz ${s}_MNI_final+tlrc" >> a_$s.sh
	
	#qsub a_$s.sh
done