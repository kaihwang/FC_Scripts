#!/bin/bash

WD='/home/despoB/kaihwang/TRSE/TRSEPPI/AllSubjs'

Both_vols='342..455,684..797,1026..1139,1368..1481,2166..2279'
FH_vols='0..113,798..911,1140..1253,1482..1595,1824..1937'
HF_vols='114..227,456..569,1254..1367,1596..1709,1938..2051'
Cat_vols='228..341,684..797,912..1025,1710..1823,2052..2165'

for s in 1106; do

	mkdir /tmp/${s}

	for pipeline in FIR; do
		
		3dBandpass -input ${WD}/${s}/${pipeline}_errts.nii.gz \
		-band 0.009 0.08 \
		-automask \
		-prefix /tmp/${s}/${pipeline}_errts_bp.nii.gz

		#parse
		3dTcat -prefix /tmp/${s}/${s}_${pipeline}_Both_errts_bp.nii.gz \
		/tmp/${s}/${pipeline}_errts_bp.nii.gz[${Both_vols}]

		3dTcat -prefix /tmp/${s}/${s}_${pipeline}_FH_errts_bp.nii.gz \
		/tmp/${s}/${pipeline}_errts_bp.nii.gz[${FH_vols}]

		3dTcat -prefix /tmp/${s}/${s}_${pipeline}_HF_errts_bp.nii.gz \
		/tmp/${s}/${pipeline}_errts_bp.nii.gz[${HF_vols}]

		3dTcat -prefix /tmp/${s}/${s}_${pipeline}_Cat_errts_bp.nii.gz \
		/tmp/${s}/${pipeline}_errts_bp.nii.gz[${Cat_vols}]

		for condition in Both FH HF Cat; do

			#need to run Gordon first
			for roi in Gordon_333_cortical_LPI; do

				3dNetCorr \
				-inset /tmp/${s}/${s}_${pipeline}_${condition}_errts_bp.nii.gz \
				-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
				-ts_out \
				-prefix /tmp/${s}/${s}_${pipeline}_${condition}_${roi}

				mv /tmp/${s}/${s}_${pipeline}_${condition}_${roi}_000.netts /home/despoB/connectome-thalamus/NotBackedUp/TS/
			done

			for roi in Thalamus_WTA_LPI Morel_LPI; do

				3dNetCorr \
				-inset /tmp/${s}/${s}_${pipeline}_${condition}_errts_bp.nii.gz \
				-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
				-ts_out \
				-prefix /tmp/${s}/${s}_${pipeline}_${condition}_${roi}

				mv /tmp/${s}/${s}_${pipeline}_${condition}_${roi}_000.netts /home/despoB/connectome-thalamus/NotBackedUp/TS/
				
				#subject, condition, tharoi = raw_input().split()
				echo "${s} ${condition} ${roi}" | python /home/despoB/kaihwang/bin/FC_Scripts/cal_pcorr.py
				#num=$(expr $(wc -l /tmp/${s}/${s}_${pipeline}_${condition}_${roi}_000.netcc | awk '{print $1}') - 6)
				#tail -n $num /tmp/${s}/${s}_${pipeline}_${condition}_${roi}_000.netcc > /home/despoB/kaihwang/TRSE/TDSigEI/Graph/${s}_${pipeline}_${condition}_${roi}_bcorrmat.txt
			
			done
		done
	done

	rm -rf /tmp/${s}
done 





# #script to calculate adj matrices from TRSE beta series

# WD='/home/despo/clg5026/data/trse_bseries/Data'

# for s in 630; do


# 	for condition in categ_face categ_scene irrel_face irrel_scene relev_face relev_scene; do

# 		for roi in Gordon_plus_thalamus_WTA_LPI Gordon_plus_Morel_LPI; do

# 			3dNetCorr \
# 			-inset ${WD}/${s}/corrtrials_nocensor_rmerror_wboth/${s}_${condition}_betas.nii.gz \
# 			-in_rois /home/despoB/connectome-thalamus/ROIs/${roi}.nii.gz \
# 			-prefix /home/despoB/kaihwang/TRSE/TRSEPPI/Graph/Adj_${s}_${condition}_${roi}

# 			num=$(expr $(wc -l /home/despoB/kaihwang/TRSE/TRSEPPI/Graph/Adj_${s}_${condition}_${roi}_000.netcc | awk '{print $1}') - 6)
# 			tail -n $num /home/despoB/kaihwang/TRSE/TRSEPPI/Graph/Adj_${s}_${condition}_${roi}_000.netcc > /home/despoB/kaihwang/TRSE/TRSEPPI/Graph/${s}_${condition}_${roi}_bcorrmat.txt

# 		done
# 	done
# done

