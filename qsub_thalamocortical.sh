#!/bin/bash
# script for sge batch jobs
WD='/home/despoB/connectome-thalamus/MGH'

#cd ${WD}/usable_sub

for Subject in $(cat ${WD}/usable_sub); do

        #if [ ! -e "/home/despoB/kaihwang/Rest/Graph/g_${Subject}.mat" ]; then
        sed "s/s in Sub0001_Ses1/s in ${Subject}/g" < do_thalamocortical_graph_MGH.sh> tmp/thalamocortical_${Subject}.sh
        qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp tmp/thalamocortical_${Subject}.sh
        #fi

done
