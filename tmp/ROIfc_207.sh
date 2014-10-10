cd /home/despo/kaihwang/Rest/Control/207/Rest

rm 207_tsnr_mask.nii.gz
3dcalc -a 207_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix 207_tsnr_mask.nii.gz

rm *corrmat*

3dNetCorr -prefix 207_Full_corrmat -inset 207-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask 207_tsnr_mask.nii.gz
3dNetCorr -prefix 207_Right_corrmat -inset 207-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask 207_tsnr_mask.nii.gz
3dNetCorr -prefix 207_Left_corrmat -inset 207-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask 207_tsnr_mask.nii.gz

for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do
num=$(expr $(wc -l 207_Full_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 207_Full_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t207_full_corrmat_${p}

num=$(expr $(wc -l 207_Right_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 207_Right_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t207_Right_corrmat_${p}

num=$(expr $(wc -l 207_Left_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num 207_Left_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/t207_Left_corrmat_${p}

done
matlab -nodisplay -nosplash < /home/despo/kaihwang/bin/Thalamo/ROIg207.m
