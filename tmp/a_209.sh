. /etc/bashrc
. ~/.bashrc
cd $SUBJECTS_DIR/209
cd $SUBJECTS_DIR/209/SUMA
3dcopy 209_SurfVol+orig 209_SurfVol.nii.gz
preprocessMprage -r MNI_2mm \
	-b "-R -S -B -f 0.05 -g -0.3" \
	-no_bias \
	-o 209_MNI_final.nii.gz -n 209_SurfVol.nii.gz
fslreorient2std aseg.nii aseg_r.nii.gz
rm aseg.nii
applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=209_SurfVol_warpcoef.nii.gz
3dcopy aseg_mni.nii.gz aseg_mni+tlrc
3dcopy 209_MNI_final.nii.gz 209_MNI_final+tlrc
