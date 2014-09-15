. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/218/Rest

3dTcat -prefix 218-rest-preproc-cen.nii.gz -rlt \
	reg_run1/218-preproc-run1-censored+tlrc \
	reg_run2/218-preproc-run2-censored+tlrc \
	reg_run3/218-preproc-run3-censored+tlrc \
	reg_run4/218-preproc-run4-censored+tlrc \
	reg_run5/218-preproc-run5-censored+tlrc \
	reg_run6/218-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
