. /etc/bashrc
. ~/.bashrc

for r in 1 2; do

cd /home/despo/kaihwang/Rest/Lesion/162/Rest
gzip 162-EPI-00${r}.nii
3dcopy 162-EPI-00${r}.nii.gz 162_rest_run${r}.nii.gz
rm -rf /home/despo/kaihwang/Rest/Lesion/162/Rest/NNrun${r}/
mkdir /home/despo/kaihwang/Rest/Lesion/162/Rest/NNrun${r}/
mv 162_rest_run${r}.nii.gz /home/despo/kaihwang/Rest/Lesion/162/Rest/NNrun${r}/
cd /home/despo/kaihwang/Rest/Lesion/162/Rest/NNrun${r}/

preprocessFunctional -4d 162_rest_run${r}.nii.gz \
		-tr 2 \
		-mprage_bet /home/despo/kaihwang/Subjects/162/SUMA/162_SurfVol_bet.nii.gz \
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
		-warpcoef /home/despo/kaihwang/Subjects/162/SUMA/162_SurfVol_warpcoef.nii.gz \
		-startover

cd /home/despo/kaihwang/Rest/Lesion/162/Rest/NNrun${r}/
3dWarp -deoblique -prefix dbrnswdkmt_162_rest_run${r}_6.nii.gz -quintic brnswdkmt_162_rest_run${r}_6.nii.gz

done


cd /home/despo/kaihwang/Rest/Lesion/162/Rest

3dTcat -prefix 162-rest-preproc-cen.nii.gz -rlt++ \
		NNrun1/dbrnswdkmt_162_rest_run1_6.nii.gz \
		NNrun2/dbrnswdkmt_162_rest_run2_6.nii.gz 

3dTstat -mean -prefix m1.nii.gz NNrun1/wdkmt_162_rest_run1.nii.gz
3dTstat -mean -prefix m2.nii.gz NNrun2/wdkmt_162_rest_run2.nii.gz
3dTstat -stdev -prefix s1.nii.gz NNrun1/wdkmt_162_rest_run1.nii.gz
3dTstat -stdev -prefix s2.nii.gz NNrun2/wdkmt_162_rest_run2.nii.gz
3dcalc -a m1.nii.gz -b m2.nii.gz -c s1.nii.gz -d s2.nii.gz -expr '((a/c)+(b/d))/2' -prefix 162_tsnr_mean.nii.gz
rm m*.nii.gz; rm s*.nii.gz

rm 162_tsnr_mask.nii.gz
3dcalc -a 162_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix 162_tsnr_mask.nii.gz

rm *corrmat*

3dNetCorr -prefix 162_Full_corrmat -inset 162-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask 162_tsnr_mask.nii.gz
3dNetCorr -prefix 162_Right_corrmat -inset 162-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask 162_tsnr_mask.nii.gz
3dNetCorr -prefix 162_Left_corrmat -inset 162-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask 162_tsnr_mask.nii.gz

for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do
num=$(expr $(wc -l 162_Full_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 162_Full_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t162_full_corrmat_${p}

num=$(expr $(wc -l 162_Right_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 162_Right_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t162_Right_corrmat_${p}

num=$(expr $(wc -l 162_Left_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 162_Left_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t162_Left_corrmat_${p}

done
