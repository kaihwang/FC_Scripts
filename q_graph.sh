#!/bin/sh

#script to submit matlab jobs for calculating graphs
#114 116 117 119 128 162 163 168 176 201 203 204 205 206 207 208 209 210 211 212 213 215 218 220

for s in 163; do

	echo "addpath(genpath('/home/despo/kaihwang/bin/'));" >> g${s}.m

	echo "addpath(genpath('/home/despo/kaihwang/matlab/'));" >> g${s}.m
	
	echo "[Adj, Graph] = cal_graph('${s}');" >> g${s}.m
	
	echo "save /home/despo/kaihwang/Rest/Graph/g_${s}.mat; exit;" >> g${s}.m
	
	echo "matlab -nodisplay -nosplash < /home/despo/kaihwang/bin/Thalamo/g${s}.m" >> g_${s}.sh
	
	qsub -V -m e -e ~/tmp -o ~/tmp g_${s}.sh
done