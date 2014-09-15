. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/208/Rest

3dTcat -prefix 208-rest-preproc-cen.nii.gz -rlt \
	reg_run1/208-preproc-run1-censored+tlrc \
	reg_run2/208-preproc-run2-censored+tlrc \
	reg_run3/208-preproc-run3-censored+tlrc \
	reg_run4/208-preproc-run4-censored+tlrc \
	reg_run5/208-preproc-run5-censored+tlrc \
	reg_run6/208-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
