#use 3dNetcorr cal correlation bewteen morel nuclei and Yeo ROIs (17 netowrk, 400 ROIs)

#Do HCP 

cd /home/despoB/connectome-data

for s in 100206; do  #$(/bin/ls -d *)



	for roi in Morel_plus_Yeo17 Morel_plus_Yeo400; do

		for sequence in rfMRI_REST1_LR rfMRI_REST1_RL rfMRI_REST2_LR rfMRI_REST2_RL; do
			3dNetCorr -prefix ~/tmp/${s}_${roi}_${sequence} -inset /home/despoB/connectome-data/${s}/${sequence}/${sequence}_hp2000_clean.nii.gz \
			-in_rois /home/despoB/kaihwang/Rest/ThaGate/ROIs/${roi}.nii.gz 

			num=$(expr $(wc -l ~/tmp/${s}_${roi}_${sequence}_000.netcc | awk '{print $1}') - 6)
			tail -n $num ~/tmp/${s}_${roi}_${sequence}_000.netcc > /home/despoB/kaihwang/Rest/ThaGate/Matrices/HCP_${s}_${roi}_${sequence}_corrmat

		done
	done



	for roi in Morel_plus_Yeo17; do

		for sequence in rfMRI_REST1_LR rfMRI_REST1_RL rfMRI_REST2_LR rfMRI_REST2_RL; do
			3dNetCorr -prefix ~/tmp/${s}_${roi}_${sequence}_partial -inset /home/despoB/connectome-data/${s}/${sequence}/${sequence}_hp2000_clean.nii.gz \
			-in_rois /home/despoB/kaihwang/Rest/ThaGate/ROIs/${roi}.nii.gz -part_corr

			num=$(expr $(wc -l ~/tmp/${s}_${roi}_${sequence}_partial_000.netcc | awk '{print $1}') - 6)
			tail -n $num ~/tmp/${s}_${roi}_${sequence}_partial_000.netcc > /home/despoB/kaihwang/Rest/ThaGate/Matrices/HCP_${s}_${roi}_${sequence}_partial_corrmat

		done
	done

done


