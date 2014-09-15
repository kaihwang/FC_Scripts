. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/205/Rest

3dTcat -prefix 205-rest-preproc-cen.nii.gz -rlt \
	reg_run1/205-preproc-run1-censored+tlrc \
	reg_run2/205-preproc-run2-censored+tlrc \
	reg_run3/205-preproc-run3-censored+tlrc \
	reg_run4/205-preproc-run4-censored+tlrc \
	reg_run5/205-preproc-run5-censored+tlrc \
	reg_run6/205-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
