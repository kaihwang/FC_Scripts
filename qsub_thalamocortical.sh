#!/bin/bash
# script for sge batch jobs
WD='/home/despoB/connectome-thalamus/MGH'

#cd ${WD}/usable_sub

#for Subject in $(cat ${WD}/usable_sub); do

# for Subject in 1103 1220 1306 1223 1314 1311 1318 1313 1326 1325 1328 1329 1333 1331 1335 1338 1336 1339 1337 1344 1340; do
#         #if [ ! -e "/home/despoB/kaihwang/Rest/Graph/g_${Subject}.mat" ]; then
# 	sed "s/s in 1103/s in ${Subject}/g" < do_thalamocortical_graph_old.sh> ~/tmp/S${Subject}.sh
# 	qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/S${Subject}.sh
#         #fi

# done

for Subject in 1103 1220 1306 1223 1314 1311 1318 1313 1326 1325 1328 1329 1333 1331 1335 1338 1336 1339 1337 1344 1340; do
        #if [ ! -e "/home/despoB/kaihwang/Rest/Graph/g_${Subject}.mat" ]; then
	sed "s/s in 1103/s in ${Subject}/g" < do_striatalcortical_graph_old.sh> ~/tmp/Ss_${Subject}.sh
	qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/Ss_${Subject}.sh
        #fi

done