. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/117/Rest

3dTcat -prefix 117-rest-preproc-cen.nii.gz -rlt \
	reg_run1/117-preproc-run1-censored+tlrc \
	reg_run2/117-preproc-run2-censored+tlrc \
	reg_run3/117-preproc-run3-censored+tlrc \
	reg_run4/117-preproc-run4-censored+tlrc \
	reg_run5/117-preproc-run5-censored+tlrc \
	reg_run6/117-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
