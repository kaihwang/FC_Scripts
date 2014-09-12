. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/220/Rest
gzip 220-EPI-001.nii
3dcopy 220-EPI-001.nii.gz 220_rest_run1.nii.gz
mkdir /home/despo/kaihwang/Rest/Control/220/Rest/run1/
mv 220_rest_run1.nii.gz /home/despo/kaihwang/Rest/Control/220/Rest/run1/
cd /home/despo/kaihwang/Rest/Control/220/Rest/run1/

preprocessFunctional -4d 220_rest_run1.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/220/SUMA/220_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/220/SUMA/220_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_220_rest_run1.nii.gz 220_rest_proc_run1+tlrc
cp /home/despo/kaihwang/Rest/Control/220/Rest/run1/motion.par \
		/home/despo/kaihwang/Rest/Control/220/Rest/run1/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/220/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/220/SUMA/220_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Control/220/Rest/run1/220_rest_proc_run1+tlrc \
		-dest /home/despo/kaihwang/Rest/Control/220/Rest/reg_run1/ \
		-prefix 220-preproc-run1 \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Control/220/Rest/run1/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run1

cd /home/despo/kaihwang/Rest/Control/220/Rest/reg_run1/
afni_restproc.py -apply_censor \
		220-preproc-run1.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Control/220/Rest/run1/motion_info/censor_intersection.1D \
		220-preproc-run1-censored

rm -rf /home/despo/kaihwang/Rest/Control/220/Rest/reg_run1/tmp
rm /home/despo/kaihwang/Rest/Control/220/Rest/run1/*t_*run*
