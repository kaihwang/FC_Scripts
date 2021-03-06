#!/bin/bash

cd /home/despoB/kaihwang/Rest/Older_Controls

for s in 1101 1102 1103 1104 1209 1210 1214 1220 1222 1223 1306 1307 1309 1310 1311 1313 1314 1318 1325 1326 1328 1329 1331 1333 1335 1336 1337 1338 1339 1340 1342 1343 1344 1345 1346 1347 1349 1350; do

	mkdir ${s}

	if [ -d "/home/despo/reach/Aging_Rehab_Study/Analysis/reach_mri/${s}/SourceDICOMs/Resting_Scan_1/" ]; then
		cp -r /home/despo/reach/Aging_Rehab_Study/Analysis/reach_mri/${s}/SourceDICOMs/Resting_Scan_1 ${s}/rest_run1
	fi

	if [ -d "/home/despo/reach/Aging_Rehab_Study/Analysis/reach_mri/${s}/SourceDICOMs/Resting_Scan/" ]; then
		cp -r /home/despo/reach/Aging_Rehab_Study/Analysis/reach_mri/${s}/SourceDICOMs/Resting_Scan ${s}/rest_run1
	fi

	if [ -d "/home/despo/reach/Aging_Rehab_Study/Analysis/reach_mri/${s}/SourceDICOMs/Resting_Scan_2/" ]; then
		cp -r /home/despo/reach/Aging_Rehab_Study/Analysis/reach_mri/${s}/SourceDICOMs/Resting_Scan_2 ${s}/rest_run2
	fi

	cp -r /home/despo/reach/Aging_Rehab_Study/Analysis/reach_mri/${s}/SourceDICOMs/MPRAGE ${s}/mprage
done