. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/220/Rest

3dTcat -prefix 220-rest-preproc-cen.nii.gz -rlt \
	reg_run1/220-preproc-run1-censored+tlrc \
	reg_run2/220-preproc-run2-censored+tlrc \
	reg_run3/220-preproc-run3-censored+tlrc \
	reg_run4/220-preproc-run4-censored+tlrc \
	reg_run5/220-preproc-run5-censored+tlrc \
	reg_run6/220-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
