#!bin/bash/
# this is to run connectome dat through regular afni_restproc.py instead of calling local WM regression. To compare between pipelines.


WD='/home/despoB/connectome-thalamus'

#     
for s in 128329  134324  140925  148335  153833  159441  165032  172534  179548  189349  196144 ; do

	for run in rfMRI_REST1_LR  rfMRI_REST1_RL rfMRI_REST2_LR  rfMRI_REST2_RL  ; do
		
		cd $WD/connectome/${s}/MNINonLinear/

		mkdir /tmp/KH_${s}_${run}

		3dcopy T1w_restore_brain.nii.gz anat
		mv anat+tlrc* /tmp/KH_${s}_${run}
		
		cp ${run}_mopar.1D /tmp/KH_${s}_${run}
		cp aseg+tlrc* /tmp/KH_${s}_${run}

		3dcopy ${run}.nii.gz ${run}_input
		mv ${run}_input* /tmp/KH_${s}_${run}
		
		cd /tmp/KH_${s}_${run}

		afni_restproc.py \
		-anat anat+tlrc \
		-epi ${run}_input+tlrc \
		-trcut 0 \
		-align off \
		-globalwm \
		-aseg aseg+tlrc \
		-dest ${run}_afni_restproc \
		-regressor ${run}_mopar.1D \
		-smoothrad 5 \
		-despike off \
		-polort 3 \
		-bandpass \
		-bpassregs \
		-script proc_test \
		-prefix ${run}_gwreg_bp

		3dAFNItoNIFTI -prefix $WD/connectome/${s}/MNINonLinear/${run}_gwreg_bp.nii.gz ${run}_afni_restproc/${run}_gwreg_bp.cleanEPI+tlrc

		rm -rf /tmp/KH_${s}_${run}	
	done

done