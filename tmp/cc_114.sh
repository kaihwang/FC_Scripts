. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/114/Rest

3dTcat -prefix 114-rest-preproc-cen.nii.gz -rlt \
	reg_run1/114-preproc-run1-censored+tlrc \
	reg_run2/114-preproc-run2-censored+tlrc \
	reg_run3/114-preproc-run3-censored+tlrc \
	reg_run4/114-preproc-run4-censored+tlrc \
	reg_run5/114-preproc-run5-censored+tlrc \
	reg_run6/114-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
