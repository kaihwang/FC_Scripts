#!/bin/sh

#script to create subject data folder for control subjects

for s in 114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220; do
	
	mkdir /home/despo/kaihwang/Rest/Control/${s}
	mkdir /home/despo/kaihwang/Rest/Control/${s}/Rest
	cp /home/despo/mb3152/data/Rest.ShamTMS/Data/${s}/Rest/${s}-EPI-00*.nii* /home/despo/kaihwang/Rest/Control/${s}/Rest
	
	
done