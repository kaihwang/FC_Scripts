cd /home/despo/kaihwang/Rest/Lesion/162/Rest

3dTcat -prefix 162-rest-preproc-cen.nii.gz -rlt \
	reg_run1/162-preproc-run1-censored+tlrc \
	reg_run2/162-preproc-run2-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
