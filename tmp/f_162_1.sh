. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Lesion/162/Rest
gzip 162-EPI-001.nii
3dcopy 162-EPI-001.nii.gz 162_rest_run1.nii.gz
mkdir /home/despo/kaihwang/Rest/Lesion/162/Rest/Nrun1/
mv 162_rest_run1.nii.gz /home/despo/kaihwang/Rest/Lesion/162/Rest/Nrun1/
cd /home/despo/kaihwang/Rest/Lesion/162/Rest/Nrun1/

preprocessFunctional -4d 162_rest_run1.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/162/SUMA/162_SurfVol_bet.nii.gz \
		-threshold 98_2 \
		-rescaling_method 10000_globalmedian \
		-template_brain MNI_3mm \
		-func_struc_dof bbr \
		-warp_interpolation spline \
		-constrain_to_template y \
		-motion_censor fd=0.9,dvars=20 \
		-nuisance_regression 6motion,csf,wm,dcsf,dwm \
		-bandpass_filter 0.009 .08 \
		-wavelet_despike \
		-cleanup \
		-deoblique_all \
		-log proctest \
		-motion_sinc y \
		-no_hp \
		-no_smooth \
		-slice_acquisition interleaved \
		-warpcoef /home/despo/kaihwang/Subjects/162/SUMA/162_SurfVol_warpcoef.nii.gz \
		-startover

