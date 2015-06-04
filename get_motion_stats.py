import numpy as np


Control_Subj = ['1103', '1220', '1306', '1223', '1314', '1311', '1318', '1313', '1326', '1325', '1328', '1329', '1333', '1331', '1335', '1338', '1336', '1339', '1337', '1344']
thalamic_patients = ['128', '162', '163', '168', '176']
striatal_patients = ['b117', 'b122', 'b138', 'b143', 'b153']

Groups = {'Control Subjects': Control_Subj, 'Thalamic Patients': thalamic_patients, 'Striatal Patients': striatal_patients}
# thalamic patients

for key in Groups:
	FD_mean = np.zeros(len(Groups[key]))
	for i, s in enumerate(Groups[key]):
		
		fn = '/home/despoB/kaihwang/Rest/FDs/%s_run1_FD.1D' %(s)
		fd = np.loadtxt(fn)
		fn = '/home/despoB/kaihwang/Rest/FDs/%s_run2_FD.1D' %(s)
		fd = np.append(fd,np.loadtxt(fn))
		FD_mean[i] = np.mean(fd)

	print('%s mean FD =%s,  std = %s') %(key, np.mean(FD_mean), np.std(FD_mean))

scrubbed_mean = np.zeros(len(thalamic_patients))
for i, s in enumerate(thalamic_patients):
	fn = '/home/despoB/connectome-thalamus/Patients/%s/MNINonLinear/run1_scrub.1D' %s
	kept_vol = np.loadtxt(fn)
	fn = '/home/despoB/connectome-thalamus/Patients/%s/MNINonLinear/run2_scrub.1D' %s
	kept_vol = np.append(kept_vol, np.loadtxt(fn))

	scrubbed = 600 - len(kept_vol)
	scrubbed_mean[i] = scrubbed/600.

print('Thalamic patients: mean percentage frames scrubbed =%s,  std = %s') %(np.mean(scrubbed_mean), np.std(scrubbed_mean))

scrubbed_mean = np.zeros(len(striatal_patients))
for i, s in enumerate(striatal_patients):
	fn = '/home/despoB/connectome-thalamus/Patients/%s/MNINonLinear/run1_scrub.1D' %s
	kept_vol = np.loadtxt(fn)
	fn = '/home/despoB/connectome-thalamus/Patients/%s/MNINonLinear/run2_scrub.1D' %s
	kept_vol = np.append(kept_vol, np.loadtxt(fn))

	scrubbed = 600 - len(kept_vol)
	scrubbed_mean[i] = scrubbed/600.

print('striatal patients: mean percentage frames scrubbed =%s,  std = %s') %(np.mean(scrubbed_mean), np.std(scrubbed_mean))

scrubbed_mean = np.zeros(len(Control_Subj))
for i, s in enumerate(Control_Subj):
	fn = '/home/despoB/connectome-thalamus/Older_Controls/%s/MNINonLinear/run1_scrub.1D' %s
	kept_vol = np.loadtxt(fn)
	fn = '/home/despoB/connectome-thalamus/Older_Controls/%s/MNINonLinear/run2_scrub.1D' %s
	kept_vol = np.append(kept_vol, np.loadtxt(fn))

	scrubbed = 600 - len(kept_vol)
	scrubbed_mean[i] = scrubbed/600.

print('Controls: mean percentage frames scrubbed =%s,  std = %s') %(np.mean(scrubbed_mean), np.std(scrubbed_mean))