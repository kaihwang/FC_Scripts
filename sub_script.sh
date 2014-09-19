#!/bin/sh
# script to space out job submission.

for s in b116 b117 b120 b121 b122 b138 b143 b153;

do
	
	qsub -M kaihwang -l mem_free=5G -m e -e ~/tmp -o ~/tmp fb_${s}.sh 
	sleep 16.66m
	
done