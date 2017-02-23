#script to use 3dNetcorr to calculate corr matrices bewteen thalamic nuclei/lesion ROIs and large-scale cortical networks (Yeo networks)


#ROIs locations
# Morel + network, Morel has valus from 0 to 32

#Do HCP

cd /home/despoB/connectome-data/

for sub in 100206; do  #$(/bin/ls -d *)
	
	mkdir /tmp/${sub}

	cd /home/despoB/connectome-data/${sub}
	
	if [ -e rfMRI_REST1_LR/rfMRI_REST1_LR_hp2000_clean_wbsreg.nii.gz -a rfMRI_REST1_RL/rfMRI_REST1_RL_hp2000_clean_wbsreg.nii.gz -a rfMRI_REST2_LR/rfMRI_REST2_LR_hp2000_clean_wbsreg.nii.gz -a rfMRI_REST2_RL/rfMRI_REST2_RL_hp2000_clean_wbsreg.nii.gz ]; then
		3dTcat -prefix /tmp/${sub}/rest_wbsreg.nii.gz rfMRI_REST1_LR/rfMRI_REST1_LR_hp2000_clean_wbsreg.nii.gz rfMRI_REST1_RL/rfMRI_REST1_RL_hp2000_clean_wbsreg.nii.gz rfMRI_REST2_LR/rfMRI_REST2_LR_hp2000_clean_wbsreg.nii.gz rfMRI_REST2_RL/rfMRI_REST2_RL_hp2000_clean_wbsreg.nii.gz
		
		for roi in 128_plus_Yeo 162_plus_Yeo 163_plus_Yeo 168_plus_Yeo 176_plus_Yeo Morel_plus_Yeo; do
			3dNetCorr -prefix ~/tmp/${sub}_${roi} -inset /tmp/${sub}/rest_wbsreg.nii.gz \
			-in_rois /home/despoB/kaihwang/Rest/ThaGate/ROIs/${roi}.nii.gz

			num=$(expr $(wc -l ~/tmp/${sub}_${roi}_000.netcc | awk '{print $1}') - 6)
			tail -n $num ~/tmp/${sub}_${roi}_000.netcc > /home/despoB/kaihwang/Rest/ThaGate/Matrices/HCP_${sub}_${roi}_corrmat
		done

	fi	

done

#_wbsreg.nii.gz