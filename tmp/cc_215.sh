. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/215/Rest

3dTcat -prefix 215-rest-preproc-cen.nii.gz -rlt \
	reg_run1/215-preproc-run1-censored+tlrc \
	reg_run2/215-preproc-run2-censored+tlrc \
	reg_run3/215-preproc-run3-censored+tlrc \
	reg_run4/215-preproc-run4-censored+tlrc \
	reg_run5/215-preproc-run5-censored+tlrc \
	reg_run6/215-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
