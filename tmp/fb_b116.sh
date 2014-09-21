. /etc/bashrc
. ~/.bashrc

for r in 1 2; do

cd /home/despo/kaihwang/Rest/BG/b116/Rest
gzip b116-EPI-00${r}.nii
3dcopy b116-EPI-00${r}.nii.gz b116_rest_run${r}.nii.gz
rm -rf /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/
mkdir /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/
mv b116_rest_run${r}.nii.gz /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/
cd /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/

preprocessFunctional -4d b116_rest_run${r}.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/b116/SUMA/b116_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/b116/SUMA/b116_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_b116_rest_run${r}.nii.gz b116_rest_proc_run${r}+tlrc
cp /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/motion.par \
		/home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/b116/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/b116/SUMA/b116_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/b116_rest_proc_run${r}+tlrc \
		-dest /home/despo/kaihwang/Rest/BG/b116/Rest/reg_run${r}/ \
		-prefix b116-preproc-run${r} \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run${r}

cd /home/despo/kaihwang/Rest/BG/b116/Rest/reg_run${r}/
afni_restproc.py -apply_censor \
		b116-preproc-run${r}.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/motion_info/censor_intersection.1D \
		b116-preproc-run${r}-censored

rm -rf /home/despo/kaihwang/Rest/BG/b116/Rest/reg_run${r}/tmp
rm /home/despo/kaihwang/Rest/BG/b116/Rest/run${r}/*t_*run*
done


cd /home/despo/kaihwang/Rest/BG/b116/Rest

3dTcat -prefix b116-rest-preproc-cen.nii.gz -rlt \
		reg_run1/b116-preproc-run1-censored+tlrc \
		reg_run2/b116-preproc-run2-censored+tlrc


mv reg*/*tsnr* .
rm -rf reg_run*
