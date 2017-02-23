#script to use 3dNetcorr to calculate corr matrices bewteen thalamic nuclei/lesion ROIs and large-scale cortical networks (Yeo networks)


#ROIs locations
# Morel + network, Morel has valus from 0 to 32

#Do MGH



cd /home/despoB/kaihwang/Rest/MGH

for s in Sub0001_Ses1; do  #$(/bin/ls -d *)


	for roi in 128_plus_Yeo 162_plus_Yeo 163_plus_Yeo 168_plus_Yeo 176_plus_Yeo Morel_plus_Yeo; do
		3dNetCorr -prefix ~/tmp/${s}_${roi} -inset /home/despoB/kaihwang/Rest/MGH/${s}/MNINonLinear/rfMRI_REST_ncsreg.nii.gz \
		-in_rois /home/despoB/kaihwang/Rest/ThaGate/ROIs/${roi}.nii.gz 

		num=$(expr $(wc -l ~/tmp/${s}_${roi}_000.netcc | awk '{print $1}') - 6)
		tail -n $num ~/tmp/${s}_${roi}_000.netcc > /home/despoB/kaihwang/Rest/ThaGate/Matrices/MGH_${s}_${roi}_corrmat
	done

done