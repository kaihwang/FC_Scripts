. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/219/Rest

3dTcat -prefix 219-rest-preproc-cen.nii.gz -rlt \
	reg_run1/219-preproc-run1-censored+tlrc \
	reg_run2/219-preproc-run2-censored+tlrc \
	reg_run3/219-preproc-run3-censored+tlrc \
	reg_run4/219-preproc-run4-censored+tlrc \
	reg_run5/219-preproc-run5-censored+tlrc \
	reg_run6/219-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
