. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/214/Rest

3dTcat -prefix 214-rest-preproc-cen.nii.gz -rlt \
	reg_run1/214-preproc-run1-censored+tlrc \
	reg_run2/214-preproc-run2-censored+tlrc \
	reg_run3/214-preproc-run3-censored+tlrc \
	reg_run4/214-preproc-run4-censored+tlrc \
	reg_run5/214-preproc-run5-censored+tlrc \
	reg_run6/214-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
