#!/bin/bash

# script to submit PPI analysis to the grid

mkdir tmp;

#cd /home/despo/kaihwang/Rest/Connectome

for Subject in $(ls /home/despo/kaihwang/Rest/Connectome/* -d | grep -Eo '[0-9]{1,6}'); do
	sed "s/s in 100307/s in ${Subject}/g" < proc_connectome.sh > tmp/q_proc_connectome_${Subject}.sh
	qsub -V -M kaihwang -m e -l mem_free=10G -e ~/tmp -o ~/tmp tmp/q_proc_connectome_${Subject}.sh
	wait 3.33m
done
