cd /home/despo/kaihwang/Rest/Lesion/168/Rest

3dTcat -prefix 168-rest-preproc-cen.nii.gz -rlt \
	reg_run1/168-preproc-run1-censored+tlrc \
	reg_run2/168-preproc-run2-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
