. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/116/Rest
gzip 116-EPI-006.nii
3dcopy 116-EPI-006.nii.gz 116_rest_run6.nii.gz
mkdir /home/despo/kaihwang/Rest/Control/116/Rest/run6/
mv 116_rest_run6.nii.gz /home/despo/kaihwang/Rest/Control/116/Rest/run6/
cd /home/despo/kaihwang/Rest/Control/116/Rest/run6/

preprocessFunctional -4d 116_rest_run6.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/116/SUMA/116_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/116/SUMA/116_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_116_rest_run6.nii.gz 116_rest_proc_run6+tlrc
cp /home/despo/kaihwang/Rest/Control/116/Rest/run6/motion.par \
		/home/despo/kaihwang/Rest/Control/116/Rest/run6/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/116/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/116/SUMA/116_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Control/116/Rest/run6/116_rest_proc_run6+tlrc \
		-dest /home/despo/kaihwang/Rest/Control/116/Rest/reg_run6/ \
		-prefix 116-preproc-run6 \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Control/116/Rest/run6/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run6

cd /home/despo/kaihwang/Rest/Control/116/Rest/reg_run6/
afni_restproc.py -apply_censor \
		116-preproc-run6.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Control/116/Rest/run6/motion_info/censor_intersection.1D \
		116-preproc-run6-censored

rm -rf /home/despo/kaihwang/Rest/Control/116/Rest/reg_run6/tmp
rm /home/despo/kaihwang/Rest/Control/116/Rest/run6/*t_*run*
