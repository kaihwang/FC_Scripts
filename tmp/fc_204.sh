. /etc/bashrc
. ~/.bashrc

for r in 1 2 3 4 5 6; do

cd /home/despo/kaihwang/Rest/Control/204/Rest
gzip 204-EPI-00${r}.nii
3dcopy 204-EPI-00${r}.nii.gz 204_rest_run${r}.nii.gz
rm -rf /home/despo/kaihwang/Rest/Control/204/Rest/NNrun${r}/
mkdir /home/despo/kaihwang/Rest/Control/204/Rest/NNrun${r}/
mv 204_rest_run${r}.nii.gz /home/despo/kaihwang/Rest/Control/204/Rest/NNrun${r}/
cd /home/despo/kaihwang/Rest/Control/204/Rest/NNrun${r}/

preprocessFunctional -4d 204_rest_run${r}.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/204/SUMA/204_SurfVol_bet.nii.gz \
		-threshold 98_2 \
		-rescaling_method 10000_globalmedian \
		-template_brain MNI_3mm \
		-func_struc_dof bbr \
		-warp_interpolation spline \
		-constrain_to_template y \
		-motion_censor fd=0.9,dvars=20 \
		-motion_sinc y \
		-nuisance_regression 6motion,csf,wm,d6motion \
		-bandpass_filter 0.009 .08 \
		-wavelet_despike \
		-wavelet_m1000 \
		-st_first \
		-cleanup \
		-log preproc \
		-no_hp \
		-smoothing_kernel 6 \
		-slice_acquisition interleaved \
		-warpcoef /home/despo/kaihwang/Subjects/204/SUMA/204_SurfVol_warpcoef.nii.gz \
		-startover

cd /home/despo/kaihwang/Rest/Control/204/Rest/NNrun${r}/
3dWarp -deoblique -prefix dbrnswdkmt_204_rest_run${r}_6.nii.gz -quintic brnswdkmt_204_rest_run${r}_6.nii.gz

done


cd /home/despo/kaihwang/Rest/Control/204/Rest

rm 204-rest-preproc-cen.nii.gz
3dTcat -prefix 204-rest-preproc-cen.nii.gz -rlt++ \
		NNrun1/dbrnswdkmt_204_rest_run1_6.nii.gz \
		NNrun2/dbrnswdkmt_204_rest_run2_6.nii.gz \
		NNrun3/dbrnswdkmt_204_rest_run3_6.nii.gz \
		NNrun4/dbrnswdkmt_204_rest_run4_6.nii.gz \
		NNrun5/dbrnswdkmt_204_rest_run5_6.nii.gz \
		NNrun6/dbrnswdkmt_204_rest_run6_6.nii.gz 

3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_204_rest_run1.nii.gz
3dTstat -mean -prefix m2.nii.gz NNrun2/wdkmt_204_rest_run2.nii.gz
3dTstat -mean -prefix m3.nii.gz NNrun3/wdkmt_204_rest_run3.nii.gz
3dTstat -mean -prefix m4.nii.gz NNrun4/wdkmt_204_rest_run4.nii.gz
3dTstat -mean -prefix m5.nii.gz NNrun5/wdkmt_204_rest_run5.nii.gz
3dTstat -mean -prefix m6.nii.gz NNrun6/wdkmt_204_rest_run6.nii.gz
3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_204_rest_run1.nii.gz
3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_204_rest_run2.nii.gz
3dTstat -stdev -prefix s3.nii.gz NNrun3/wdkmt_204_rest_run3.nii.gz
3dTstat -stdev -prefix s4.nii.gz NNrun4/wdkmt_204_rest_run4.nii.gz
3dTstat -stdev -prefix s5.nii.gz NNrun5/wdkmt_204_rest_run5.nii.gz
3dTstat -stdev -prefix s6.nii.gz NNrun6/wdkmt_204_rest_run6.nii.gz
3dcalc -a m1.nii.gz -b s1.nii.gz -c m2.nii.gz -d s2.nii.gz -e m3.nii.gz -f s3.nii.gz -g m4.nii.gz -h s4.nii.gz -i m5.nii.gz -j s5.nii.gz -k m6.nii.gz -l s6.nii.gz -expr '((a/b)+(c/d)+(e/f)+(g/h)+(i/j)+(k/l))/6' -prefix 204_tsnr_mean.nii.gz
rm m*.nii.gz; rm s*.nii.gz

rm 204_tsnr_mask.nii.gz
3dcalc -a 204_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix 204_tsnr_mask.nii.gz

rm *corrmat*

3dNetCorr -prefix 204_Full_corrmat -inset 204-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask 204_tsnr_mask.nii.gz
3dNetCorr -prefix 204_Right_corrmat -inset 204-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask 204_tsnr_mask.nii.gz
3dNetCorr -prefix 204_Left_corrmat -inset 204-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask 204_tsnr_mask.nii.gz

for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do
num=$(expr $(wc -l 204_Full_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 204_Full_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t204_full_corrmat_${p}

num=$(expr $(wc -l 204_Right_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 204_Right_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t204_Right_corrmat_${p}

num=$(expr $(wc -l 204_Left_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 204_Left_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t204_Left_corrmat_${p}

done
