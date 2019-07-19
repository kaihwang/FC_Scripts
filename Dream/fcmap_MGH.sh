


cd /home/kahwang/DreamROIs/
ROIs=$(ls *.nii.gz)

cd /data/backed_up/shared/MGH/MGH

for MGH_sub in Sub0001_Ses1; do #$(ls -d Sub*)

	if [ -f /data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST2.nii.gz ]; then

		3dTcat -prefix /data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST.nii.gz \
		/data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST1.nii.gz \
		/data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST2.nii.gz

		3dmerge -1blur_fwhm 4.0 -doall -prefix /data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST_s4mm.nii.gz \
		/data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST.nii.gz

		3dNetCorr -inset /data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST_s4mm.nii.gz -fish_z \
			-in_rois /home/kahwang/DreamROIs/Combined_ROIs/combined_all.nii.gz -prefix /home/kahwang/DreamROIs/seedmaps/combined_all.nii.gz_${MGH_sub}

		#get rid of header
		cat /home/kahwang/DreamROIs/seedmaps/combined_all.nii.gz_${MGH_sub}.netcc | tail -n 71 > /home/kahwang/DreamROIs/seedmaps/combined_all.nii.gz_${MGH_sub}.corrmat

		for seed_ROI in $ROIs; do

			3dNetCorr -inset /data/backed_up/shared/MGH/MGH/${MGH_sub}/MNINonLinear/rfMRI_REST_s4mm.nii.gz \
			-in_rois /home/kahwang/DreamROIs/${seed_ROI} -ts_wb_Z -prefix /home/kahwang/DreamROIs/seedmaps/${seed_ROI}_${MGH_sub}

			3dAFNItoNIFTI -prefix /home/kahwang/DreamROIs/seedmaps/${seed_ROI}_${MGH_sub}.nii.gz \
			/home/kahwang/DreamROIs/seedmaps/${seed_ROI}_${MGH_sub}_000_INDIV/WB_Z_ROI_001+orig

		done
	fi

done


cd /home/kahwang/DreamROIs/
