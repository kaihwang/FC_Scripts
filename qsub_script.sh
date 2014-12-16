#!/bin/bash

# script to submit PPI analysis to the grid


mkdir tmp;

WD='/home/despoB/connectome-thalamus'

#cd /home/despo/kaihwang/Rest/Connectome

#for Subject in $(ls /home/despoB/connectome-raw/* -d | grep -Eo '[0-9]{1,6}'); do
for Subject in 100307	108323  119833  129432  138231  148335  156233  164030  173435  185442  196750  205826  217126  298455  382242  486759  571548  645551  734045  814649  894673  979984 100408  108525  120111  129533  138534  148840  156637  164131  173536  186141  197348  207628  217429  303119  385450  497865  573249  650746  742549  816653  896778  983773 ; do
	
	if [ ! -d "${WD}/connectome/${Subject}/" ]; then
		sed "s/s in 100307/s in ${Subject}/g" < proc_connectome.sh > tmp/q_proc_connectome_${Subject}.sh
		qsub -V -M kaihwang -m e -l mem_free=6G -e ~/tmp -o ~/tmp tmp/q_proc_connectome_${Subject}.sh
	fi

done
