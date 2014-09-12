cd /home/despo/kaihwang/Rest/Lesion/163/Rest

3dTcat -prefix 163-rest-preproc-cen.nii.gz -rlt \
	reg_run1/163-preproc-run1-censored+tlrc \
	reg_run2/163-preproc-run2-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
