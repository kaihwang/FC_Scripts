#!/bin/bash
# script for sge batch jobs



WD='/home/despoB/connectome-thalamus/connectome'

for s in $(cat ${WD}/list_of_complete_subjects); do
	#if [ ! -e "/home/despoB/kaihwang/Rest/Graph/gsetCI_${Subject}.mat" ]; then
	sed "s/s in 100307/s in ${s}/g" < hcp_FIX_preproc.sh > ~/tmp/hcp${s}.sh
	qsub -l mem_free=6G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/hcp${s}.sh
	#fi

done
