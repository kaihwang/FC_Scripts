. /etc/bashrc
. ~/.bashrc
cd $SUBJECTS_DIR/162
@SUMA_Make_Spec_FS -sid 162
cd $SUBJECTS_DIR/162/SUMA
3dcopy 162_SurfVol+orig 162_SurfVol.nii.gz
preprocessMprage -r MNI_2mm \
	-b "-R -f 0.2 -g -0.2" \
	-o 162_MNI_final.nii.gz -n 162_SurfVol.nii.gz
fslreorient2std aseg.nii aseg_r.nii.gz
rm aseg.nii
applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=162_SurfVol_warpcoef.nii.gz
3dcopy aseg_mni.nii.gz aseg_mni+tlrc
3dcopy 162_MNI_final.nii.gz 162_MNI_final+tlrc
