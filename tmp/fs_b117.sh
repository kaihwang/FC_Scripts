. /etc/bashrc
. ~/.bashrc

recon-all -i /home/despo/kaihwang/Rest/BG/b117/Rest/b117-T1.nii.gz -all -subjid b117

cd $SUBJECTS_DIR/b117
@SUMA_Make_Spec_FS -sid b117

cd $SUBJECTS_DIR/b117/SUMA
3dcopy b117_SurfVol+orig b117_SurfVol.nii.gz
preprocessMprage -r MNI_2mm \
	-b "-R -S -B -f 0.05 -g -0.3" \
	-no_bias \
	-o b117_MNI_final.nii.gz -n b117_SurfVol.nii.gz
fslreorient2std aseg.nii aseg_r.nii.gz
rm aseg.nii
applywarp -i aseg_r.nii.gz \
	-r template_brain.nii -o aseg_mni.nii.gz \
	--warp=b117_SurfVol_warpcoef.nii.gz
3dcopy aseg_mni.nii.gz aseg_mni+tlrc
3dcopy b117_MNI_final.nii.gz b117_MNI_final+tlrc
