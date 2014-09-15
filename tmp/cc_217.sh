. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/217/Rest

3dTcat -prefix 217-rest-preproc-cen.nii.gz -rlt \
	reg_run1/217-preproc-run1-censored+tlrc \
	reg_run2/217-preproc-run2-censored+tlrc \
	reg_run3/217-preproc-run3-censored+tlrc \
	reg_run4/217-preproc-run4-censored+tlrc \
	reg_run5/217-preproc-run5-censored+tlrc \
	reg_run6/217-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
