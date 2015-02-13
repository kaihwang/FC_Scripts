#!/bin/bash



# cd /home/despo/kaihwang/Rest/Connectome

# for Subject in 128 162 163 168 176; do

# 		sed "s/s in 128/s in ${Subject}/g" < proc_th_HCPpreproc_reg_bp.sh> tmp/q_proc_th_HCPpreproc_reg_bp_${Subject}.sh
# 		qsub -V -M kaihwang -m e -l mem_free=5G -e ~/tmp -o ~/tmp tmp/q_proc_th_HCPpreproc_reg_bp_${Subject}.sh
# done

# for Subject in b116 b117 b120 b121 b122 b138 b143 b144 b153; do

# 		sed "s/s in 128/s in ${Subject}/g" < proc_bg_HCPpreproc_reg_bp.sh> tmp/q_proc_bg_HCPpreproc_reg_bp_${Subject}.sh
# 		qsub -V -M kaihwang -m e -l mem_free=5G -e ~/tmp -o ~/tmp tmp/q_proc_bg_HCPpreproc_reg_bp_${Subject}.sh
# done

# for Subject in 114 117 119 203 205 207 209 211 213 215 217 219 116 118 201 204 206 208 210 212 214 216 218 220; do

# 		sed "s/s in 128/s in ${Subject}/g" < proc_c_HCPpreproc_reg_bp.sh> tmp/q_proc_c_HCPpreproc_reg_bp_${Subject}.sh
# 		qsub -V -M kaihwang -m e -l mem_free=5G -e ~/tmp -o ~/tmp tmp/q_proc_c_HCPpreproc_reg_bp_${Subject}.sh
# done


# for Subject in 162 163 168 176 b116 b117 b120 b121 b122 b138 b143 b144 b153; do

# 	sed "s/s in 128/s in ${Subject}/g" < align_masks.sh> tmp/align_masks_${Subject}.sh
# 	qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp tmp/align_masks_${Subject}.sh

# done

for Subject in 1103 1220 1222 1223 1306 1307 1309 1310 1311 1313 1314 1318 1325 1326 1328 1329 1331 1333 1335 1336 1337 1338 1339 1340 1342 1343 1344 1345 1346 1347 1349 1350; do

	sed "s/s in 1103/s in ${Subject}/g" < proc_ag_HCPpreproc_reg_bp.sh> tmp/q_proc_ag_HCPpreproc_reg_bp_${Subject}.sh
	qsub -V -M kaihwang -m e -l mem_free=5G -e ~/tmp -o ~/tmp tmp/q_proc_ag_HCPpreproc_reg_bp_${Subject}.sh

done
