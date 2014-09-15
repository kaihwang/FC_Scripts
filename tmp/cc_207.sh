. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/207/Rest

3dTcat -prefix 207-rest-preproc-cen.nii.gz -rlt \
	reg_run1/207-preproc-run1-censored+tlrc \
	reg_run2/207-preproc-run2-censored+tlrc \
	reg_run3/207-preproc-run3-censored+tlrc \
	reg_run4/207-preproc-run4-censored+tlrc \
	reg_run5/207-preproc-run5-censored+tlrc \
	reg_run6/207-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
