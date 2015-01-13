#!/bin/bash

mkdir tmp;

WD='/home/despoB/connectome-thalamus'

#cd /home/despo/kaihwang/Rest/Connectome

for Subject in $(cat /home/despoB/kaihwang/Rest/connectome/list_of_complete_subjects); do
#for Subject in 268850; do	
	
	#if [ ! -d "${WD}/connectome/${Subject}/" ]; then
		sed "s/s in 100307/s in ${Subject}/g" < do_333ROI_con_graph_connectome.sh > tmp/do_333ROI_con_graph_${Subject}.sh
		qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp tmp/do_333ROI_con_graph_${Subject}.sh  #-l mem_free=5G
	#fi

done
