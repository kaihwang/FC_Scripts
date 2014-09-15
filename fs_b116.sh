. /etc/bashrc
. ~/.bashrc

recon-all -i /home/despo/kaihwang/Rest/BG/b116/Rest/b116-T1.nii.gz -all -subjid b116

cd $SUBJECTS_DIR/b116
@SUMA_Make_Spec_FS -sid b116

cd $SUBJECTS_DIR/b116/SUMA
3dcopy b116_SurfVol+orig b116_SurfVol.nii.gz
preprocessMprage -r MNI_2mm \
	-b "-R -S -B -f 0.05 -g -0.3" \
	-no_bias \
	-o b116_MNI_final.nii.gz -n b116_SurfVol.nii.gz
fslreorient2std aseg.nii aseg_r.nii.gz
rm aseg.nii
applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=b116_SurfVol_warpcoef.nii.gz
3dcopy aseg_mni.nii.gz aseg_mni+tlrc
3dcopy b116_MNI_final.nii.gz b116_MNI_final+tlrc
