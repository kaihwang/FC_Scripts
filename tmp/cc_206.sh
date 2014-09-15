. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/206/Rest

3dTcat -prefix 206-rest-preproc-cen.nii.gz -rlt \
	reg_run1/206-preproc-run1-censored+tlrc \
	reg_run2/206-preproc-run2-censored+tlrc \
	reg_run3/206-preproc-run3-censored+tlrc \
	reg_run4/206-preproc-run4-censored+tlrc \
	reg_run5/206-preproc-run5-censored+tlrc \
	reg_run6/206-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
