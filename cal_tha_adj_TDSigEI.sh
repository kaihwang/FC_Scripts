#!/bin/bash

#scropt to do filtering and adj calculation on TDSigEI

WD='/home/despoB/kaihwang/TRSE/TDSigEI'

for s in 503; do

	mkdir /tmp/${s}

	for pipeline in FIR nusiance; do
		for condition in FH HF Fp Hp; do

			3dBandpass -input ${WD}/${s}/${s}_${pipeline}_${condition}_errts.nii.gz \
			-band 0.009 0.08 \
			-automask \
			-prefix /tmp/${s}/${s}_${pipeline}_${condition}_errts_bp.nii.gz

			for roi in Gordon_plus_thalamus_WTA_LPI Gordon_plus_Morel_LPI; do

				3dNetCorr \
				-inset /tmp/${s}/${s}_${pipeline}_${condition}_errts_bp.nii.gz \
				-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
				-prefix /tmp/${s}/${s}_${pipeline}_${condition}_${roi}

				num=$(expr $(wc -l /tmp/${s}/${s}_${pipeline}_${condition}_${roi}_000.netcc | awk '{print $1}') - 6)
				tail -n $num /tmp/${s}/${s}_${pipeline}_${condition}_${roi}_000.netcc > /home/despoB/kaihwang/TRSE/TDSigEI/Graph/${s}_${pipeline}_${condition}_${roi}_bcorrmat.txt
			
			done
		done
	done

	rm -rf /tmp/${s}
done