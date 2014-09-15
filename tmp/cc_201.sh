. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/201/Rest

3dTcat -prefix 201-rest-preproc-cen.nii.gz -rlt \
	reg_run1/201-preproc-run1-censored+tlrc \
	reg_run2/201-preproc-run2-censored+tlrc \
	reg_run3/201-preproc-run3-censored+tlrc \
	reg_run4/201-preproc-run4-censored+tlrc \
	reg_run5/201-preproc-run5-censored+tlrc \
	reg_run6/201-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
