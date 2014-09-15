. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/204/Rest

3dTcat -prefix 204-rest-preproc-cen.nii.gz -rlt \
	reg_run1/204-preproc-run1-censored+tlrc \
	reg_run2/204-preproc-run2-censored+tlrc \
	reg_run3/204-preproc-run3-censored+tlrc \
	reg_run4/204-preproc-run4-censored+tlrc \
	reg_run5/204-preproc-run5-censored+tlrc \
	reg_run6/204-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
