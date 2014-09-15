. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/209/Rest

3dTcat -prefix 209-rest-preproc-cen.nii.gz -rlt \
	reg_run1/209-preproc-run1-censored+tlrc \
	reg_run2/209-preproc-run2-censored+tlrc \
	reg_run3/209-preproc-run3-censored+tlrc \
	reg_run4/209-preproc-run4-censored+tlrc \
	reg_run5/209-preproc-run5-censored+tlrc \
	reg_run6/209-preproc-run6-censored+tlrc

mv reg*/*tsnr* .
rm -rf reg_run*
