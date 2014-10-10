#!/bin/sh
# script to space out job submission.

for s in 116 117 118 119 128 162 163 168 176 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 b116 b117 b120 b121 b122 b138 b143 b153;

do
	
	qsub -M kaihwang -m e -e ~/tmp -o ~/tmp graph_${s}.sh 
	#sleep 16.66m
	
done