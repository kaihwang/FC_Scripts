. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/216/Rest

3dTcat -prefix 216-rest-preproc-cen.nii.gz -rlt \
	reg_run1/216-preproc-run1-censored+tlrc \
	reg_run2/216-preproc-run2-censored+tlrc \
	reg_run3/216-preproc-run3-censored+tlrc \
	reg_run4/216-preproc-run4-censored+tlrc \
	reg_run5/216-preproc-run5-censored+tlrc \
	reg_run6/216-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
