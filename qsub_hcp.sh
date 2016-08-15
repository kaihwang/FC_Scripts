#!/bin/bash
# script for sge batch jobs



# WD='/home/despoB/connectome-thalamus/NKI'
# SCRIPT='/home/despoB/kaihwang/bin/Thalamo'
# cd ${WD}

# for s in $(ls -d 0*); do
# 	#if [ ! -e "/home/despoB/kaihwang/Rest/Graph/gsetCI_${Subject}.mat" ]; then
# 	sed "s/s in 0102826_session_1/s in ${s}/g" < ${SCRIPT}/cal_adj.sh > ~/tmp/s${s}.sh
# 	qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/s${s}.sh
# 	#fi

# done


WD='/home/despoB/connectome-thalamus/NKI'
SCRIPT='/home/despoB/kaihwang/bin/Thalamo'
cd ${WD}

for s in $(/bin/ls -d *); do
	#if [ ! -e "/home/despoB/kaihwang/Rest/Graph/gsetCI_${Subject}.mat" ]; then
	sed "s/s in 0102826_session_1/s in ${s}/g" < ${SCRIPT}/cal_adj.sh > ~/tmp/g${s}.sh
	qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/g${s}.sh
	#fi`

done
