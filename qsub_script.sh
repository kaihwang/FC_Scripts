#!/bin/bash

# script to submit PPI analysis to the grid


mkdir tmp;

WD='/home/despoB/connectome-thalamus'

#cd /home/despo/kaihwang/Rest/Connectome

for Subject in $(ls /home/despoB/connectome-raw/* -d | grep -Eo '[0-9]{1,6}'); do
#for Subject in 268850; do	
	
	if [ ! -d "${WD}/connectome/${Subject}/" ]; then
		sed "s/s in 100307/s in ${Subject}/g" < proc_connectome.sh > tmp/q_proc_connectome_${Subject}.sh
		qsub -V -M kaihwang -m e -l mem_free=6G -e ~/tmp -o ~/tmp tmp/q_proc_connectome_${Subject}.sh
	fi

done
