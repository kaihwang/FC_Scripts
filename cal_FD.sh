#!/bin/bash
#script to calculate FD


# cd /home/despoB/kaihwang/Rest/Patients
# Patients=$(ls -d *)

# for s in $Patients; do

# 	cd /home/despoB/kaihwang/Rest/Patients/${s}/MNINonLinear
# 	for r in 1 2; do
# 		1d_tool.py -infile rfMRI_REST${r}_PA_mopar.1D -derivative -write motion.diff.1D
# 		1deval -a motion.diff.1D[0] -expr '2*pi*50*(a/360)' > rot_x.1D
# 		1deval -a motion.diff.1D[1] -expr '2*pi*50*(a/360)' > rot_y.1D
# 		1deval -a motion.diff.1D[2] -expr '2*pi*50*(a/360)' > rot_z.1D
# 		1dcat rot_x.1D rot_y.1D rot_z.1D motion.diff.1D[3..5] > ${s}.motion.diff.despike.1D
# 		1deval -a ${s}.motion.diff.despike.1D[0] \
# 		-b ${s}.motion.diff.despike.1D[1] \
# 		-c ${s}.motion.diff.despike.1D[2] \
# 		-d ${s}.motion.diff.despike.1D[3] \
# 		-e ${s}.motion.diff.despike.1D[4] \
# 		-f ${s}.motion.diff.despike.1D[5] \
# 		-expr 'abs(a)+abs(b)+abs(c)+abs(d)+abs(e)+abs(f)' > ${s}_run${r}_FD.1D

# 		rm motion.diff.1D
# 		rm rot_x.1D
# 		rm rot_y.1D
# 		rm rot_z.1D
# 		rm ${s}.motion.diff.despike.1D
# 		rm ${s}_run${r}_scrub.1D
# 		rm run${r}_scrub.1D

# 		1deval -a ${s}_run${r}_FD.1D -expr 'step(isnegative(a-0.3))' | grep -n 1 | cut -f1 -d: > tmp.1D
# 		1deval -a tmp.1D -expr 'a-1' > run${r}_scrub.1D
# 		wc -l run${r}_scrub.1D

# 		rm tmp.1D
# 	done
# done


# cd /home/despoB/kaihwang/Rest/Older_Controls
# Older_Controls=$(ls -d 1*)

# for s in $Older_Controls; do

# 	cd /home/despoB/kaihwang/Rest/Older_Controls/${s}/MNINonLinear
# 	for r in 1 2; do
# 		1d_tool.py -infile rfMRI_REST${r}_PA_mopar.1D -derivative -write motion.diff.1D
# 		1deval -a motion.diff.1D[0] -expr '2*pi*50*(a/360)' > rot_x.1D
# 		1deval -a motion.diff.1D[1] -expr '2*pi*50*(a/360)' > rot_y.1D
# 		1deval -a motion.diff.1D[2] -expr '2*pi*50*(a/360)' > rot_z.1D
# 		1dcat rot_x.1D rot_y.1D rot_z.1D motion.diff.1D[3..5] > ${s}.motion.diff.despike.1D
# 		1deval -a ${s}.motion.diff.despike.1D[0] \
# 		-b ${s}.motion.diff.despike.1D[1] \
# 		-c ${s}.motion.diff.despike.1D[2] \
# 		-d ${s}.motion.diff.despike.1D[3] \
# 		-e ${s}.motion.diff.despike.1D[4] \
# 		-f ${s}.motion.diff.despike.1D[5] \
# 		-expr 'abs(a)+abs(b)+abs(c)+abs(d)+abs(e)+abs(f)' > ${s}_run${r}_FD.1D

# 		rm motion.diff.1D
# 		rm rot_x.1D
# 		rm rot_y.1D
# 		rm rot_z.1D
# 		rm ${s}.motion.diff.despike.1D
# 		rm ${s}_run${r}_scrub.1D
# 		rm run${r}_scrub.1D
		
# 		1deval -a ${s}_run${r}_FD.1D -expr 'step(isnegative(a-0.3))' | grep -n 1 | cut -f1 -d: > tmp.1D
# 		1deval -a tmp.1D -expr 'a-1' > run${r}_scrub.1D
# 		wc -l run${r}_scrub.1D

# 		rm tmp.1D
# 	done
# done

cd /home/despoB/kaihwang/Rest/Control
Controls=$(ls -d *)

for s in $Controls; do

	cd /home/despoB/kaihwang/Rest/Control/${s}/MNINonLinear
	for r in 1 2 3 4 5 6; do
		1d_tool.py -infile rfMRI_REST${r}_PA_mopar.1D -derivative -write motion.diff.1D
		1deval -a motion.diff.1D[0] -expr '2*pi*50*(a/360)' > rot_x.1D
		1deval -a motion.diff.1D[1] -expr '2*pi*50*(a/360)' > rot_y.1D
		1deval -a motion.diff.1D[2] -expr '2*pi*50*(a/360)' > rot_z.1D
		1dcat rot_x.1D rot_y.1D rot_z.1D motion.diff.1D[3..5] > ${s}.motion.diff.despike.1D
		1deval -a ${s}.motion.diff.despike.1D[0] \
		-b ${s}.motion.diff.despike.1D[1] \
		-c ${s}.motion.diff.despike.1D[2] \
		-d ${s}.motion.diff.despike.1D[3] \
		-e ${s}.motion.diff.despike.1D[4] \
		-f ${s}.motion.diff.despike.1D[5] \
		-expr 'abs(a)+abs(b)+abs(c)+abs(d)+abs(e)+abs(f)' > ${s}_run${r}_FD.1D

		rm motion.diff.1D
		rm rot_x.1D
		rm rot_y.1D
		rm rot_z.1D
		rm ${s}.motion.diff.despike.1D
		rm ${s}_run${r}_scrub.1D
		rm run${r}_scrub.1D
		
		1deval -a ${s}_run${r}_FD.1D -expr 'step(isnegative(a-0.3))' | grep -n 1 | cut -f1 -d: > tmp.1D
		1deval -a tmp.1D -expr 'a-1' > run${r}_scrub.1D
		wc -l run${r}_scrub.1D

		rm tmp.1D
	done
done