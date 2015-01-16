#!/bin/bash

mkdir tmp;

WD='/home/despoB/kaihwang/Rest/Older_Controls'

#cd /home/despo/kaihwang/Rest/Connectome
cd ${WD}

for Subject in $(ls -d 1*); do
#for Subject in 268850; do	
	
	#if [ ! -d "${WD}/connectome/${Subject}/" ]; then
		sed "s/ss in 1103/s in ${Subject}/g" < q_ana_preproc.sh > tmp/anatomical_${Subject}.sh
		qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp tmp/anatomical_${Subject}.sh  #-l mem_free=5G
	#fi

done
