
#TDSigEI
WD='/home/despoB/kaihwang/TRSE/TDSigEI'


cd ${WD}
for s in $(/bin/ls -d 5*); do
	for data in HF FH Hp Fp Ho Fo; do
		for roi in Morel_plus_Yeo400_LPI; do 
			3dNetCorr \
			-inset ${WD}/${s}/${s}_FIR_${data}_ertts.nii.gz \
			-in_rois /home/despoB/kaihwang/Rest/ROIs/${roi}.nii.gz \
			-ts_out \
			-prefix /home/despoB/kaihwang/Rest/ThaGate/NotBackedUp/${s}_Morel_plus_Yeo400_${data}
		done
	done
done



#TRSE
WD='/home/despoB/kaihwang/TRSE/TRSEPPI/AllSubjs'

cd ${WD}
for s in $(cat /home/despoB/kaihwang/bin/TDSigEI/Models/test.subjects); do
	for data in HF FH CAT BO; do
		for roi in Morel_plus_Yeo400_LPI; do 
			3dNetCorr \
			-inset ${WD}/${s}/${s}_FIR_${data}_ertts.nii.gz \
			-in_rois /home/despoB/kaihwang/Rest/ROIs/${roi}.nii.gz \
			-ts_out \
			-prefix /home/despoB/kaihwang/Rest/ThaGate/NotBackedUp/${s}_Morel_plus_Yeo400_${data}
		done
	done
done