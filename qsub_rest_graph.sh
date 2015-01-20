#!/bin/bash
# script for sge batch jobs


#cd /home/despo/kaihwang/Rest/Connectome

for Subject in 128 162 163 168 176 b116 b117 b120 b121 b122 b138 b143 b144 b153; do

	if [ ! -e "/home/despoB/kaihwang/Rest/Graph/g_${Subject}.mat" ]; then
	sed "s/s in 128/s in ${Subject}/g" < do_333ROI_con_graph.sh > tmp/graph_${Subject}.sh
	qsub -V -M kaihwang -m e -e ~/tmp -o ~/tmp tmp/graph_${Subject}.sh
	fi
	
done


for Subject in 114 117 119 203 205 207 209 211 213 215 217 219 116 118 201 204 206 208 210 212 214 216 218 220; do

	if [ ! -e "/home/despoB/kaihwang/Rest/Graph/g_${Subject}.mat" ]; then
	sed "s/s in 128/s in ${Subject}/g" < do_333ROI_con_graph_control.sh > tmp/graph_${Subject}.sh
	qsub -V -M kaihwang -l mem_free=14G -m e -e ~/tmp -o ~/tmp tmp/graph_${Subject}.sh
	fi

done


for Subject in $(cat /home/despoB/kaihwang/Rest/connectome/list_of_complete_subjects); do

	if [ ! -e "/home/despoB/kaihwang/Rest/Graph/g_${Subject}.mat" ]; then
	sed "s/s in 100307/s in ${Subject}/g" < do_333ROI_con_graph_connectome.sh > tmp/graph_${Subject}.sh
	qsub -V -M kaihwang -l mem_free=10G -m e -e ~/tmp -o ~/tmp tmp/graph_${Subject}.sh
	fi

done
