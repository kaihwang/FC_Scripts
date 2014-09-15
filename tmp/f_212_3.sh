. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/212/Rest
gzip 212-EPI-003.nii
3dcopy 212-EPI-003.nii.gz 212_rest_run3.nii.gz
mkdir /home/despo/kaihwang/Rest/Control/212/Rest/run3/
mv 212_rest_run3.nii.gz /home/despo/kaihwang/Rest/Control/212/Rest/run3/
cd /home/despo/kaihwang/Rest/Control/212/Rest/run3/

preprocessFunctional -4d 212_rest_run3.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/212/SUMA/212_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/212/SUMA/212_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_212_rest_run3.nii.gz 212_rest_proc_run3+tlrc
cp /home/despo/kaihwang/Rest/Control/212/Rest/run3/motion.par \
		/home/despo/kaihwang/Rest/Control/212/Rest/run3/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/212/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/212/SUMA/212_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Control/212/Rest/run3/212_rest_proc_run3+tlrc \
		-dest /home/despo/kaihwang/Rest/Control/212/Rest/reg_run3/ \
		-prefix 212-preproc-run3 \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Control/212/Rest/run3/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run3

cd /home/despo/kaihwang/Rest/Control/212/Rest/reg_run3/
afni_restproc.py -apply_censor \
		212-preproc-run3.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Control/212/Rest/run3/motion_info/censor_intersection.1D \
		212-preproc-run3-censored

rm -rf /home/despo/kaihwang/Rest/Control/212/Rest/reg_run3/tmp
rm /home/despo/kaihwang/Rest/Control/212/Rest/run3/*t_*run*
