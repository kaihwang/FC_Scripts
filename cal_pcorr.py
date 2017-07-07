# an improved version of calculating partial corr

import sys
from FuncParcel import *

#/tmp/${s}/${s}_${pipeline}_${condition}_${roi}_TS_000.netts

def function_cal_pcorr_mat(subject , condition, tharoi, corroi ='Gordon_333_cortical_LPI', pipeline = 'FIR'):
	ts_path = '/home/despoB/connectome-thalamus/NotBackedUp/TS/'
	pcorr_path = '/home/despoB/kaihwang/Rest/NotBackedUp/ParMatrices/'
	fn = ts_path + subject + '_%s_%s_%s_000.netts' %(pipeline, condition, tharoi)
	thalamus_ts = np.loadtxt(fn)
	#Gordon_333_cortical_LPI
	fn = ts_path + subject + '_%s_%s_%s_000.netts' %(pipeline, condition, corroi)
	cortical_roi_ts = np.loadtxt(fn)

	pcorr_mat = pcorr_subcortico_cortical_connectivity(thalamus_ts, cortical_roi_ts)
	
	fn = pcorr_path + subject + '_' + pipeline + '_' + condition + '_' + tharoi + '_pcorr_mat'
	#np.savetxt(fn, pcorr_mat, fmt='%.4f')
	np.savetxt(fn, pcorr_mat)

subject, pipeline, condition, tharoi = raw_input().split()
#subject = sys.stdin.read().strip('\n')


function_cal_pcorr_mat(subject, condition, tharoi, pipeline = pipeline)
