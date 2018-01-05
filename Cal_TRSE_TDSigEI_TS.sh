
#TDSigEI
WD='/home/despoB/kaihwang/TRSE/TDSigEI'


cd ${WD}
for s in $(/bin/ls -d 5*); do
	for data in HF FH Hp Fp Ho Fo; do
		for roi in Morel_Striatum_Yeo400_LPI Morel_Striatum_Gordon_LPI WTA_Striatum_Gordon_LPI; do 
			3dNetCorr \
			-inset /home/despoB/kaihwang/TRSE/TDSigEI/NoGS/${s}_FIR_${data}_errts_nogs.nii.gz \
			-in_rois /home/despoB/kaihwang/Rest/ThaGate/ROIs/${roi}.nii.gz \
			-ts_out \
			-prefix /home/despoB/kaihwang/Rest/ThaGate/NotBackedUp/${s}_${roi}_${data}
		done
	done
done



#TRSE
WD='/home/despoB/kaihwang/TRSE/TRSEPPI/AllSubjs'

cd ${WD}
for s in $(cat /home/despoB/kaihwang/bin/TDSigEI/Models/test.subjects); do  #$(cat /home/despoB/kaihwang/bin/TDSigEI/Models/test.subjects)
	for data in HF FH CAT BO; do
		for roi in Morel_Striatum_Yeo400_LPI Morel_Striatum_Gordon_LPI WTA_Striatum_Gordon_LPI; do 
			3dNetCorr \
			-inset ${WD}/${s}/${s}_FIR_${data}_errts.nii.gz \
			-in_rois /home/despoB/kaihwang/Rest/ThaGate/ROIs/${roi}.nii.gz \
			-ts_out \
			-prefix /home/despoB/kaihwang/Rest/ThaGate/NotBackedUp/${s}_${roi}_${data}
		done
	done
done