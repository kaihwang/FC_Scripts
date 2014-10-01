. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Lesion/162/Rest
gzip 162-EPI-002.nii
3dcopy 162-EPI-002.nii.gz 162_rest_run2.nii.gz
rm -rf /home/despo/kaihwang/Rest/Lesion/162/Rest/run2/
mkdir /home/despo/kaihwang/Rest/Lesion/162/Rest/run2/
mv 162_rest_run2.nii.gz /home/despo/kaihwang/Rest/Lesion/162/Rest/run2/
cd /home/despo/kaihwang/Rest/Lesion/162/Rest/run2/

preprocessFunctional -4d 162_rest_run2.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/162/SUMA/162_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/162/SUMA/162_SurfVol_warpcoef.nii.gz \
		-startover

