. /etc/bashrc
. ~/.bashrc

for r in 1 2 3 4 5 6; do

cd /home/despo/kaihwang/Rest/Control/118/Rest
gzip 118-EPI-00${r}.nii
3dcopy 118-EPI-00${r}.nii.gz 118_rest_run${r}.nii.gz
rm -rf /home/despo/kaihwang/Rest/Control/118/Rest/run${r}/
mkdir /home/despo/kaihwang/Rest/Control/118/Rest/run${r}/
mv 118_rest_run${r}.nii.gz /home/despo/kaihwang/Rest/Control/118/Rest/run${r}/
cd /home/despo/kaihwang/Rest/Control/118/Rest/run${r}/

preprocessFunctional -4d 118_rest_run${r}.nii.gz \
		-tr 1.37 \
		-mprage_bet /home/despo/kaihwang/Subjects/118/SUMA/118_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/118/SUMA/118_SurfVol_warpcoef.nii.gz \
		-startover

done


