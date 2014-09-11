. /etc/bashrc
. ~/.bashrc
cd $SUBJECTS_DIR/215
cd $SUBJECTS_DIR/215/SUMA
3dcopy 215_SurfVol+orig 215_SurfVol.nii.gz
preprocessMprage -r MNI_2mm \
	-b "-R -S -B -f 0.05 -g -0.3" \
	-no_bias \
	-o 215_MNI_final.nii.gz -n 215_SurfVol.nii.gz
fslreorient2std aseg.nii aseg_r.nii.gz
rm aseg.nii
applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=215_SurfVol_warpcoef.nii.gz
3dcopy aseg_mni.nii.gz aseg_mni+tlrc
3dcopy 215_MNI_final.nii.gz 215_MNI_final+tlrc
