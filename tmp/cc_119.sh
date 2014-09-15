. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/119/Rest

3dTcat -prefix 119-rest-preproc-cen.nii.gz -rlt \
	reg_run1/119-preproc-run1-censored+tlrc \
	reg_run2/119-preproc-run2-censored+tlrc \
	reg_run3/119-preproc-run3-censored+tlrc \
	reg_run4/119-preproc-run4-censored+tlrc \
	reg_run5/119-preproc-run5-censored+tlrc \
	reg_run6/119-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
