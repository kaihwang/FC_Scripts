


cd /home/kahwang/DreamROIs/
ROIs=$(ls *.nii.gz)

cd /data/backed_up/shared/NKI

for sub in 0102826_session_1; do #$(ls -d *)

	3dmerge -1blur_fwhm 4.0 -doall -prefix /data/backed_up/shared/NKI/${sub}/MNINonLinear/rfMRI_REST_s4mm.nii.gz \
	/data/backed_up/shared/NKI/${sub}/MNINonLinear/rfMRI_REST_mx_645.nii.gz

	3dNetCorr -inset /data/backed_up/shared/NKI/${sub}/MNINonLinear/rfMRI_REST_s4mm.nii.gz -fish_z \
		-in_rois /home/kahwang/DreamROIs/Combined_ROIs/combined_all.nii.gz -prefix /home/kahwang/DreamROIs/seedmaps/combined_all.nii.gz_${sub}

	#get rid of header
	cat /home/kahwang/DreamROIs/seedmaps/combined_all.nii.gz_${sub}.netcc | tail -n 71 > /home/kahwang/DreamROIs/seedmaps/combined_all.nii.gz_${sub}.corrmat

	for seed_ROI in $ROIs; do

		3dNetCorr -inset /data/backed_up/shared/NKI/${sub}/MNINonLinear/rfMRI_REST_s4mm.nii.gz \
		-in_rois /home/kahwang/DreamROIs/${seed_ROI} -ts_wb_Z -prefix /home/kahwang/DreamROIs/seedmaps/${seed_ROI}_${sub}

		3dAFNItoNIFTI -prefix /home/kahwang/DreamROIs/seedmaps/${seed_ROI}_${sub}.nii.gz \
		/home/kahwang/DreamROIs/seedmaps/${seed_ROI}_${sub}_000_INDIV/WB_Z_ROI_001+orig

	done


done


cd /home/kahwang/DreamROIs/
