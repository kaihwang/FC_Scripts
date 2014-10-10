cd /home/despo/kaihwang/Rest/BG/b138/Rest

rm b138_tsnr_mask.nii.gz
3dcalc -a b138_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix b138_tsnr_mask.nii.gz

rm *corrmat*

3dNetCorr -prefix b138_Full_corrmat -inset b138-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask b138_tsnr_mask.nii.gz
3dNetCorr -prefix b138_Right_corrmat -inset b138-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask b138_tsnr_mask.nii.gz
3dNetCorr -prefix b138_Left_corrmat -inset b138-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask b138_tsnr_mask.nii.gz

for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do
num=$(expr $(wc -l b138_Full_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num b138_Full_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/tb138_full_corrmat_${p}

num=$(expr $(wc -l b138_Right_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num b138_Right_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/tb138_Right_corrmat_${p}

num=$(expr $(wc -l b138_Left_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num b138_Left_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/tb138_Left_corrmat_${p}

done
