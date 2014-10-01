. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Lesion/128/Rest
gzip 128-EPI-001.nii
3dcopy 128-EPI-001.nii.gz 128_rest_run1.nii.gz
rm -rf /home/despo/kaihwang/Rest/Lesion/128/Rest/run1/
mkdir /home/despo/kaihwang/Rest/Lesion/128/Rest/run1/
mv 128_rest_run1.nii.gz /home/despo/kaihwang/Rest/Lesion/128/Rest/run1/
cd /home/despo/kaihwang/Rest/Lesion/128/Rest/run1/

preprocessFunctional -4d 128_rest_run1.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/128/SUMA/128_SurfVol_bet.nii.gz \
		-threshold 98_2 \
		-rescaling_method 10000_globalmedian \
		-template_brain MNI_3mm \
		-func_struc_dof bbr \
		-warp_interpolation spline \
		-constrain_to_template y \
		-motion_censor fd=0.9,dvars=20 \
		-nuisance_regression 6motion,csf,wm,d6motion  \
		-bandpass_filter 0.009 .08 \
		-despike \
		-cleanup \
		-deoblique_all \
		-log proc_script \
		-no_hp \
		-smoothing_kernel 6 \
		-slice_acquisition interleaved \
		-warpcoef /home/despo/kaihwang/Subjects/128/SUMA/128_SurfVol_warpcoef.nii.gz \
		-startover

