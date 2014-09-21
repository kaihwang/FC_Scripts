. /etc/bashrc
. ~/.bashrc

cd /home/despo/kaihwang/Rest/Lesion/163/Rest
gzip 163-EPI-001.nii
3dcopy 163-EPI-001.nii.gz 163_rest_run1.nii.gz
mkdir /home/despo/kaihwang/Rest/Lesion/163/Rest/Nrun1/
mv 163_rest_run1.nii.gz /home/despo/kaihwang/Rest/Lesion/163/Rest/Nrun1/
cd /home/despo/kaihwang/Rest/Lesion/163/Rest/Nrun1/

preprocessFunctional -4d 163_rest_run1.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/163/SUMA/163_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/163/SUMA/163_SurfVol_warpcoef.nii.gz \
		-startover

