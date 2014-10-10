cd /home/despo/kaihwang/Rest/BG/b122/Rest

rm b122_tsnr_mask.nii.gz
3dcalc -a b122_tsnr_mean.nii.gz -expr 'step(a-5)' -prefix b122_tsnr_mask.nii.gz

rm *corrmat*

3dNetCorr -prefix b122_Full_corrmat -inset b122-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set.nii.gz -mask b122_tsnr_mask.nii.gz
3dNetCorr -prefix b122_Right_corrmat -inset b122-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_R.nii.gz -mask b122_tsnr_mask.nii.gz
3dNetCorr -prefix b122_Left_corrmat -inset b122-rest-preproc-cen.nii.gz -in_rois /home/despo/kaihwang/Rest/ROIs/ROIs_Set_L.nii.gz -mask b122_tsnr_mask.nii.gz

for p in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22; do
num=$(expr $(wc -l b122_Full_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num b122_Full_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/tb122_full_corrmat_${p}

num=$(expr $(wc -l b122_Right_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num b122_Right_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/tb122_Right_corrmat_${p}

num=$(expr $(wc -l b122_Left_corrmat_0${p}.netcc | awk '{print $1}') - 4)
tail -n $num b122_Left_corrmat_0${p}.netcc > /home/despo/kaihwang/Rest/AdjMatrices/tb122_Left_corrmat_${p}

done
