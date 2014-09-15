. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/116/Rest

3dTcat -prefix 116-rest-preproc-cen.nii.gz -rlt \
	reg_run1/116-preproc-run1-censored+tlrc \
	reg_run2/116-preproc-run2-censored+tlrc \
	reg_run3/116-preproc-run3-censored+tlrc \
	reg_run4/116-preproc-run4-censored+tlrc \
	reg_run5/116-preproc-run5-censored+tlrc \
	reg_run6/116-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
