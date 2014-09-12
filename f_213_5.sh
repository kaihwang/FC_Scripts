. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/213/Rest
gzip 213-EPI-005.nii
3dcopy 213-EPI-005.nii.gz 213_rest_run5.nii.gz
mkdir /home/despo/kaihwang/Rest/Control/213/Rest/run5/
mv 213_rest_run5.nii.gz /home/despo/kaihwang/Rest/Control/213/Rest/run5/
cd /home/despo/kaihwang/Rest/Control/213/Rest/run5/

preprocessFunctional -4d 213_rest_run5.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/213/SUMA/213_SurfVol_bet.nii.gz \
		-threshold 98_2 \
		-rescaling_method 10000_globalmedian \
		-template_brain MNI_3mm \
		-func_struc_dof bbr \
		-warp_interpolation spline \
		-constrain_to_template y \
		-motion_censor fd=0.9,dvars=20 \
		-wavelet_despike \
		-cleanup \
		-deoblique_all \
		-log proctest \
		-motion_sinc y \
		-no_hp \
		-no_smooth \
		-slice_acquisition interleaved \
		-warpcoef /home/despo/kaihwang/Subjects/213/SUMA/213_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_213_rest_run5.nii.gz 213_rest_proc_run5+tlrc
cp /home/despo/kaihwang/Rest/Control/213/Rest/run5/motion.par \
		/home/despo/kaihwang/Rest/Control/213/Rest/run5/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/213/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/213/SUMA/213_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Control/213/Rest/run5/213_rest_proc_run5+tlrc \
		-dest /home/despo/kaihwang/Rest/Control/213/Rest/reg_run5/ \
		-prefix 213-preproc-run5 \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Control/213/Rest/run5/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run5

cd /home/despo/kaihwang/Rest/Control/213/Rest/reg_run5/
afni_restproc.py -apply_censor \
		213-preproc-run5.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Control/213/Rest/run5/motion_info/censor_intersection.1D \
		213-preproc-run5-censored

rm -rf /home/despo/kaihwang/Rest/Control/213/Rest/reg_run5/tmp
rm /home/despo/kaihwang/Rest/Control/213/Rest/run5/*t_*run*
