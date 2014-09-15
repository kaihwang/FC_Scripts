. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/203/Rest

3dTcat -prefix 203-rest-preproc-cen.nii.gz -rlt \
	reg_run1/203-preproc-run1-censored+tlrc \
	reg_run2/203-preproc-run2-censored+tlrc \
	reg_run3/203-preproc-run3-censored+tlrc \
	reg_run4/203-preproc-run4-censored+tlrc \
	reg_run5/203-preproc-run5-censored+tlrc \
	reg_run6/203-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
