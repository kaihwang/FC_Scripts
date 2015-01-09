#!/bin/bash


for s in 114  117  119  203  205  207  209  211  213  215  217  219  116  118  201  204  206  208  210  212  214  216  218  220; do
	cd /home/despoB/kaihwang/Rest/Control/${s}/Rest

	3dresample -master /home/despoB/kaihwang/standard/spm8_mni/T1.nii -inset 114-rest-preproc-cen.nii.gz -prefix 114-rest-preproc-cen_2mm_RPI.nii.gz

done