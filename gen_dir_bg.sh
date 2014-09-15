

for s in 116 117 120 122 138 143 144 146; do
	mkdir ~/Rest/BG/b${s}
	mkdir ~/Rest/BG/b${s}/Rest
	
	3dcopy /home/despo/mb3152/data/Rest.Lesion/Data/extra_subs/${s}/Total/NIfTI/${s}-T1.nii.gz ~/Rest/BG/b${s}/Rest/b${s}-T1.nii.gz
	
	3dcopy /home/despo/mb3152/data/Rest.Lesion/Data/extra_subs/${s}/Total/NIfTI/${s}-EPI-001.nii.gz ~/Rest/BG/b${s}/Rest/b${s}-EPI-001.nii.gz

	3dcopy /home/despo/mb3152/data/Rest.Lesion/Data/extra_subs/${s}/Total/NIfTI/${s}-EPI-002.nii.gz ~/Rest/BG/b${s}/Rest/b${s}-EPI-002.nii.gz

done