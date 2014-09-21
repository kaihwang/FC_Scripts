. /etc/bashrc
. ~/.bashrc

for r in 1 2 3 4 5 6; do

cd /home/despo/kaihwang/Rest/Control/219/Rest
gzip 219-EPI-00${r}.nii
3dcopy 219-EPI-00${r}.nii.gz 219_rest_run${r}.nii.gz
rm -rf /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/
mkdir /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/
mv 219_rest_run${r}.nii.gz /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/
cd /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/

preprocessFunctional -4d 219_rest_run${r}.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/219/SUMA/219_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/219/SUMA/219_SurfVol_warpcoef.nii.gz \
		-startover

3dcopy wdkmt_219_rest_run${r}.nii.gz 219_rest_proc_run${r}+tlrc
cp /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/motion.par \
		/home/despo/kaihwang/Rest/Control/219/Rest/run${r}/motion.1D

afni_restproc.py \
		-trcut 0 \
		-despike off \
		-aseg /home/despo/kaihwang/Subjects/219/SUMA/aseg_mni+tlrc \
		-anat /home/despo/kaihwang/Subjects/219/SUMA/219_MNI_final+tlrc \
		-epi /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/219_rest_proc_run${r}+tlrc \
		-dest /home/despo/kaihwang/Rest/Control/219/Rest/reg_run${r}/ \
		-prefix 219-preproc-run${r} \
		-align off -episize 3 \
		-dreg -regressor /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/motion.1D \
		-bandpass -bpassregs -polort 2 \
		-wmsize 20 -tsnr -smooth off -script afniproc_run${r}

cd /home/despo/kaihwang/Rest/Control/219/Rest/reg_run${r}/
afni_restproc.py -apply_censor \
		219-preproc-run${r}.cleanEPI+tlrc \
		/home/despo/kaihwang/Rest/Control/219/Rest/run${r}/motion_info/censor_intersection.1D \
		219-preproc-run${r}-censored

rm -rf /home/despo/kaihwang/Rest/Control/219/Rest/reg_run${r}/tmp
rm /home/despo/kaihwang/Rest/Control/219/Rest/run${r}/*t_*run*
done


cd /home/despo/kaihwang/Rest/Control/219/Rest

3dTcat -prefix 219-rest-preproc-cen.nii.gz -rlt \
		reg_run1/219-preproc-run1-censored+tlrc \
		reg_run2/219-preproc-run2-censored+tlrc \
		reg_run3/219-preproc-run3-censored+tlrc \
		reg_run4/219-preproc-run4-censored+tlrc \
		reg_run5/219-preproc-run5-censored+tlrc \
		reg_run6/219-preproc-run6-censored+tlrc


mv reg*/*tsnr* .
rm -rf reg_run*
