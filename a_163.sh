. /etc/bashrc
. ~/.bashrc
cd $SUBJECTS_DIR/163
@SUMA_Make_Spec_FS -sid 163
cd $SUBJECTS_DIR/163/SUMA
3dcopy 163_SurfVol+orig 163_SurfVol.nii.gz
preprocessMprage -r MNI_2mm \
	-b "-R -f 0.2 -g -0.2" \
	-o 163_MNI_final.nii.gz -n 163_SurfVol.nii.gz
fslreorient2std aseg.nii aseg_r.nii.gz
rm aseg.nii
applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=163_SurfVol_warpcoef.nii.gz
3dcopy aseg_mni.nii.gz aseg_mni+tlrc
3dcopy 163_MNI_final.nii.gz 163_MNI_final+tlrc
