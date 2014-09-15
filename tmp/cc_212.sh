. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/212/Rest

3dTcat -prefix 212-rest-preproc-cen.nii.gz -rlt \
	reg_run1/212-preproc-run1-censored+tlrc \
	reg_run2/212-preproc-run2-censored+tlrc \
	reg_run3/212-preproc-run3-censored+tlrc \
	reg_run4/212-preproc-run4-censored+tlrc \
	reg_run5/212-preproc-run5-censored+tlrc \
	reg_run6/212-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
