#!/bin/bash
# script for sge batch jobs



WD='/home/despoB/connectome-thalamus/NKI'
SCRIPT='/home/despoB/kaihwang/bin/Thalamo'
cd ${WD}

for s in $(ls -d 0*); do
	#if [ ! -e "/home/despoB/kaihwang/Rest/Graph/gsetCI_${Subject}.mat" ]; then
	sed "s/s in 0102826_session_1/s in ${s}/g" < ${SCRIPT}/ncs_reg.sh > ~/tmp/s${s}.sh
	qsub -l mem_free=5G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/s${s}.sh
	#fi

done


# WD='/home/despoB/connectome-thalamus/MGH'
# SCRIPT='/home/despoB/kaihwang/bin/Thalamo'
# cd ${WD}

# for s in $(ls -d Sub*); do
# 	#if [ ! -e "/home/despoB/kaihwang/Rest/Graph/gsetCI_${Subject}.mat" ]; then
# 	sed "s/s in Sub0001_Ses1/s in ${s}/g" < ${SCRIPT}/ncs_reg_mgh.sh > ~/tmp/${s}.sh
# 	qsub -l mem_free=5G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/${s}.sh
# 	#fi

# done