. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Control/212/Rest
gzip 212-EPI-001.nii
3dcopy 212-EPI-001.nii.gz 212_rest_run1.nii.gz
mkdir /home/despo/kaihwang/Rest/Control/212/Rest/run1/
mv 212_rest_run1.nii.gz /home/despo/kaihwang/Rest/Control/212/Rest/run1/
cd /home/despo/kaihwang/Rest/Control/212/Rest/run1/

preprocessFunctional -4d 212_rest_run1.nii.gz \
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

3dcopy wdkmt_212_rest_run1.nii.gz 212_rest_proc_run1+tlrc
cp /home/despo/kaihwang/Rest/Control/212/Rest/run1/motion.par \
		/home/despo/kaihwang/Rest/Control/212/Rest/run1/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/212/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/212/SUMA/212_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Control/212/Rest/run1/212_rest_proc_run1+tlrc \
		-dest /home/despo/kaihwang/Rest/Control/212/Rest/reg_run1/ \
		-prefix 212-preproc-run1 \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Control/212/Rest/run1/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run1

cd /home/despo/kaihwang/Rest/Control/212/Rest/reg_run1/
afni_restproc.py -apply_censor \
		212-preproc-run1.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Control/212/Rest/run1/motion_info/censor_intersection.1D \
		212-preproc-run1-censored

rm -rf /home/despo/kaihwang/Rest/Control/212/Rest/reg_run1/tmp
rm /home/despo/kaihwang/Rest/Control/212/Rest/run1/*t_*run*
