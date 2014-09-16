#!/bin/sh
# script to space out job submission.

for s in 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220;

do
	
	qsub -M kaihwang -l mem_free=5G -m e -e ~/tmp -o ~/tmp f_${s}.sh 
	sleep 33.33m
	
done