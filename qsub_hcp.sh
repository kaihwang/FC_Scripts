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


#WD='/home/despoB/connectome-thalamus/NKI'
SCRIPT='/home/despoB/kaihwang/bin/FC_Scripts'
# cd /home/despoB/kaihwang/Rest/MGH/

# for s in $(/bin/ls -d *); do
# 	sed "s/s in Sub0001_Ses1/s in ${s}/g" < ${SCRIPT}/cal_adj_MGH.sh > ~/tmp/m${s}.sh
# 	qsub -V -M kaihwang -l mem_free=8G -m e -e ~/tmp -o ~/tmp ~/tmp/m${s}.sh

# done

#SCRIPT='/home/despoB/kaihwang/bin/FC_Scripts'

# cd /home/despoB/kaihwang/TRSE/TDSigEI
# for s in $(/bin/ls -d 5*); do
# 	sed "s/s in 503/s in ${s}/g" < ${SCRIPT}/cal_tha_adj_TDSigEI.sh > ~/tmp/m${s}.sh
# 	qsub -V -M kaihwang -l mem_free=3G -m e -e ~/tmp -o ~/tmp ~/tmp/m${s}.sh
# done
# cd ${SCRIPT}

# for s in 1106 1107 1109 1110 1111 1112 1113 1114 1116 1401 1402 1403 1404 1405 1406 1407 1408 1409 1411 1412 1413 1414 1415 1416 1417 1418 1419 1422 1423 1426 1427 1429 1430 1431 620 623 627 628 629 630 631 632 633 634 636 637 638 639 640 7601 7604 7611 7613 7614 7616 7620 7621; do
# 	sed "s/s in 1106/s in ${s}/g" < ${SCRIPT}/cal_tha_adj_TRSE.sh > ~/tmp/t${s}.sh
# 	qsub -V -M kaihwang -l mem_free=12G -m e -e ~/tmp -o ~/tmp ~/tmp/t${s}.sh

# done

cd /home/despoB/connectome-data

for s in $(/bin/ls -d * | grep -E [0-9]{6}); do
 	sed "s/s in 100206/s in ${s}/g" < ${SCRIPT}/Map_Targets_HCP.sh > ~/tmp/h${s}.sh
 	qsub -V -M kaihwang -l mem_free=18G -m e -e ~/tmp -o ~/tmp ~/tmp/h${s}.sh
done


# SCRIPT='/home/despoB/kaihwang/bin/FC_Scripts'
# cd /home/despoB/lesion/anat_preproc

# for s in $(/bin/ls -d 1*); do
# 	sed "s/s in 102/s in ${s}/g" < ${SCRIPT}/preproc_lesion.sh > ~/tmp/p${s}.sh
# 	qsub -V -M kaihwang -l mem_free=20G -m e -e ~/tmp -o ~/tmp ~/tmp/p${s}.sh

# done

