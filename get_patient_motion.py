import numpy as np
import glob
import os
import pandas as pd

source='/home/despoB/kaihwang/Rest/Patients/'

os.chdir(source)

df = pd.DataFrame(columns = ['patient', 'run', 'meanFD', 'vol>0.2', 'vol>0.3', 'vol>0.4', 'vol>0.5'])
i=1
for subject in glob.glob("1*"):
	for r in [1,2]:
		fn = source + subject + "/run%s/motion_info/fd.txt" %r
		try:
			fd = np.loadtxt(fn)
			df.loc[i,'patient'] = subject
			df.loc[i,'run'] = r		
			df.loc[i,'meanFD'] = np.mean(fd)	
			df.loc[i,'vol>0.2'] = sum(fd>0.2)/np.float(len(fd))
			df.loc[i,'vol>0.3'] = sum(fd>0.3)/np.float(len(fd))
			df.loc[i,'vol>0.4'] = sum(fd>0.4)/np.float(len(fd))
			df.loc[i,'vol>0.5'] = sum(fd>0.5)/np.float(len(fd))
			i=i+1
		except:
			continue 

os.chdir('/home/despoB/kaihwang/bin/FC_Scripts')


df.to_csv('/home/despoB/kaihwang/patient_motion.csv')