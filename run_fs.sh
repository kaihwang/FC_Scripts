#!/bin/sh

# script to submit freesurfer jobs to cluster. Then process anatomical data.

for s in b116 b117 b120 b121 b122 b138 b143 b144 b153; do
	
	echo ". /etc/bashrc" >> fs_$s.sh
	echo ". ~/.bashrc" >> fs_$s.sh
	echo "" >> fs_$s.sh
	
	echo "recon-all -i /home/despo/kaihwang/Rest/BG/$s/Rest/$s-T1.nii.gz -all -subjid $s" >> fs_$s.sh
	echo "" >> fs_$s.sh
	
	#then do SUMA transformation
	echo 'cd $SUBJECTS_DIR/'$s'' >> fs_$s.sh
	echo "@SUMA_Make_Spec_FS -sid $s" >> fs_$s.sh
	echo "" >> fs_$s.sh
	
	#call preprocessMPrage for normalization
	echo 'cd $SUBJECTS_DIR/'$s/SUMA'' >> fs_$s.sh
	echo "3dcopy ${s}_SurfVol+orig ${s}_SurfVol.nii.gz" >> fs_$s.sh
	
	echo "preprocessMprage -r MNI_2mm \\
	-b \"-R -S -B -f 0.05 -g -0.3\" \\
	-no_bias \\
	-o ${s}_MNI_final.nii.gz -n ${s}_SurfVol.nii.gz" >> fs_$s.sh
	
	#align aseg, then turn it into afni format
	echo "fslreorient2std aseg.nii aseg_r.nii.gz" >> fs_$s.sh
	echo "rm aseg.nii" >> fs_$s.sh
	
	echo "applywarp -i aseg_r.nii.gz \\
	-r template_brain.nii -o aseg_mni.nii.gz \\
	--warp=${s}_SurfVol_warpcoef.nii.gz" >> fs_$s.sh
	
	echo "3dcopy aseg_mni.nii.gz aseg_mni+tlrc" >> fs_$s.sh
	echo "3dcopy ${s}_MNI_final.nii.gz ${s}_MNI_final+tlrc" >> fs_$s.sh
	
	qsub -M kaihwang -m e -e ~/tmp -o ~/tmp fs_$s.sh
	
done