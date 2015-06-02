#!/bin/bash
# script for sge batch jobs

for Subject in 128 162 163 168 176 b116 b117 b120 b121 b122 b138 b143 b144 b153; do

        #if [ ! -e "/home/despoB/kaihwang/Rest/Graph/g_${Subject}.mat" ]; then
        sed "s/s in 128/s in ${Subject}/g" < align_masks.sh > tmp/align_masks_${Subject}.sh
        qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp tmp/align_masks_${Subject}.sh
        #fi

done
