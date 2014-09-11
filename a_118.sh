. /etc/bashrc
. ~/.bashrc
cd $SUBJECTS_DIR/118
cd $SUBJECTS_DIR/118/SUMA
3dcopy 118_SurfVol+orig 118_SurfVol.nii.gz
preprocessMprage -r MNI_2mm \
	-b "-R -S -B -f 0.05 -g -0.3" \
	-no_bias \
	-o 118_MNI_final.nii.gz -n 118_SurfVol.nii.gz
fslreorient2std aseg.nii aseg_r.nii.gz
rm aseg.nii
applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=118_SurfVol_warpcoef.nii.gz
3dcopy aseg_mni.nii.gz aseg_mni+tlrc
3dcopy 118_MNI_final.nii.gz 118_MNI_final+tlrc
