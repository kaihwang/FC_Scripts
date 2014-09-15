. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/118/Rest

3dTcat -prefix 118-rest-preproc-cen.nii.gz -rlt \
	reg_run1/118-preproc-run1-censored+tlrc \
	reg_run2/118-preproc-run2-censored+tlrc \
	reg_run3/118-preproc-run3-censored+tlrc \
	reg_run4/118-preproc-run4-censored+tlrc \
	reg_run5/118-preproc-run5-censored+tlrc \
	reg_run6/118-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
