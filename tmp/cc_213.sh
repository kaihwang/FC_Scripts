. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/213/Rest

3dTcat -prefix 213-rest-preproc-cen.nii.gz -rlt \
	reg_run1/213-preproc-run1-censored+tlrc \
	reg_run2/213-preproc-run2-censored+tlrc \
	reg_run3/213-preproc-run3-censored+tlrc \
	reg_run4/213-preproc-run4-censored+tlrc \
	reg_run5/213-preproc-run5-censored+tlrc \
	reg_run6/213-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
