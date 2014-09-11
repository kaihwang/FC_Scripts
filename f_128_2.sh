. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Lesion/128/Rest
gzip 128-EPI-002.nii
3dcopy 128-EPI-002.nii.gz 128_rest_run2.nii.gz
mkdir /home/despo/kaihwang/Rest/Lesion/128/Rest/run2/
mv 128_rest_run2.nii.gz /home/despo/kaihwang/Rest/Lesion/128/Rest/run2/
cd /home/despo/kaihwang/Rest/Lesion/128/Rest/run2/

preprocessFunctional -4d 128_rest_run2.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/128/SUMA/128_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/128/SUMA/128_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_128_rest_run2.nii.gz 128_rest_proc_run2+tlrc
cp /home/despo/kaihwang/Rest/Lesion/128/Rest/run2/motion.par \
		/home/despo/kaihwang/Rest/Lesion/128/Rest/run2/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/128/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/128/SUMA/128_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Lesion/128/Rest/run2/128_rest_proc_run2+tlrc \
		-dest /home/despo/kaihwang/Rest/Lesion/128/Rest/reg_run2/ \
		-prefix 128-preproc-run2 \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Lesion/128/Rest/run2/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run2

rm -rf /home/despo/kaihwang/Rest/Lesion/128/Rest/reg_run2/tmp

cd /home/despo/kaihwang/Rest/Lesion/128/Rest/reg_run2/
afni_restproc.py -apply_censor \
		128-preproc-run2.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Lesion/128/Rest/run2/motion_info/censor_intersection.1D \
		128-preproc-run2-censored
