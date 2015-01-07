#!bin/bash/
# this is to run connectome dat through regular afni_restproc.py instead of calling local WM regression. To compare between pipelines.


WD='/home/despoB/connectome-thalamus'

# 105216  113215  120515  128127  133928  140824  148032  153429  159340  164939  172332  179346  188347  195849 100408  106016  113619  121315  128329  134324  140925  148335  153833  159441  165032  172534  179548  189349  196144
for s in 100307 ; do

	cd $WD/connectome/${s}/MNINonLinear/
	

	for run in rfMRI_REST1_LR  rfMRI_REST1_RL rfMRI_REST2_LR  rfMRI_REST2_RL  ; do
		
		mkdir /tmp/KH_${s}_${run}

		3dcopy T1w_restore_brain.nii.gz anat
		mv anat_tlrc* /tmp/KH_${s}_${run}
		
		cp ${run}_mopar.1D /tmp/KH_${s}_${run}

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

	done

done