. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/214/Rest
gzip 214-EPI-006.nii
3dcopy 214-EPI-006.nii.gz 214_rest_run6.nii.gz
mkdir /home/despo/kaihwang/Rest/Control/214/Rest/run6/
mv 214_rest_run6.nii.gz /home/despo/kaihwang/Rest/Control/214/Rest/run6/
cd /home/despo/kaihwang/Rest/Control/214/Rest/run6/

preprocessFunctional -4d 214_rest_run6.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/214/SUMA/214_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/214/SUMA/214_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_214_rest_run6.nii.gz 214_rest_proc_run6+tlrc
cp /home/despo/kaihwang/Rest/Control/214/Rest/run6/motion.par \
		/home/despo/kaihwang/Rest/Control/214/Rest/run6/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/214/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/214/SUMA/214_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Control/214/Rest/run6/214_rest_proc_run6+tlrc \
		-dest /home/despo/kaihwang/Rest/Control/214/Rest/reg_run6/ \
		-prefix 214-preproc-run6 \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Control/214/Rest/run6/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run6

cd /home/despo/kaihwang/Rest/Control/214/Rest/reg_run6/
afni_restproc.py -apply_censor \
		214-preproc-run6.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Control/214/Rest/run6/motion_info/censor_intersection.1D \
		214-preproc-run6-censored

rm -rf /home/despo/kaihwang/Rest/Control/214/Rest/reg_run6/tmp
rm /home/despo/kaihwang/Rest/Control/214/Rest/run6/*t_*run*
