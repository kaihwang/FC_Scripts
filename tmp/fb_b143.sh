. /etc/bashrc
. ~/.bashrc

for r in 1 2; do

cd /home/despo/kaihwang/Rest/BG/b143/Rest
gzip b143-EPI-00${r}.nii
3dcopy b143-EPI-00${r}.nii.gz b143_rest_run${r}.nii.gz
rm -rf /home/despo/kaihwang/Rest/BG/b143/Rest/run${r}/
mkdir /home/despo/kaihwang/Rest/BG/b143/Rest/run${r}/
mv b143_rest_run${r}.nii.gz /home/despo/kaihwang/Rest/BG/b143/Rest/run${r}/
cd /home/despo/kaihwang/Rest/BG/b143/Rest/run${r}/

preprocessFunctional -4d b143_rest_run${r}.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/b143/SUMA/b143_SurfVol_bet.nii.gz \
		-threshold 98_2 \
		-rescaling_method 10000_globalmedian \
		-template_brain MNI_3mm \
		-func_struc_dof bbr \
		-warp_interpolation spline \
		-constrain_to_template y \
		-motion_censor fd=0.9,dvars=20 \
		-nuisance_regression 6motion,csf,wm,d6motion \
		-bandpass_filter 0.009 .08 \
		-despike \
		-cleanup \
		-deoblique_all \
		-log proctest \
		-no_hp \
		-smoothing_kernel 6 \
		-slice_acquisition interleaved \
		-warpcoef /home/despo/kaihwang/Subjects/b143/SUMA/b143_SurfVol_warpcoef.nii.gz \
		-startover

done


