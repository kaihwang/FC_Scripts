cd /home/despo/kaihwang/Rest/Lesion/128/Rest

3dTcat -prefix 128-rest-preproc-cen.nii.gz -rlt \
	reg_run1/128-preproc-run1-censored+tlrc \
	reg_run2/128-preproc-run2-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
