. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/210/Rest

3dTcat -prefix 210-rest-preproc-cen.nii.gz -rlt \
	reg_run1/210-preproc-run1-censored+tlrc \
	reg_run2/210-preproc-run2-censored+tlrc \
	reg_run3/210-preproc-run3-censored+tlrc \
	reg_run4/210-preproc-run4-censored+tlrc \
	reg_run5/210-preproc-run5-censored+tlrc \
	reg_run6/210-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
