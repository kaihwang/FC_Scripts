#!/bin/bash
#do patient preprocessing in native space, then regression/bandpass/blur then ANTS normalization

WD='/home/despoB/kaihwang/Rest/Patients'
BRAIN_EXTRACTION_T1_TEMPLATE='/home/despo/dlurie/Projects/lesion_preproc/templates/adni/adni_2mm_t1_template.nii.gz'
BRAIN_EXTRACTION_PROBABILITY_MASK_TEMPLATE='/home/despo/dlurie/Projects/lesion_preproc/templates/adni/adni_2mm_brain_prob_mask.nii.gz'


cd /home/despoB/lesion/anat_preproc

for s in 102; do #$(/bin/ls 1*)
	if [ ! -d ${WD}/${s} ]; then
		mkdir ${WD}/${s}
	fi

	cd ${WD}/${s}/	
	if [ ! -d ${WD}/${s}/MPRAGE ]; then
		mkdir ${WD}/${s}/MPRAGE
		ln -s /home/despoB/lesion/data/original/nifti/sub_${s}/anat/t1mprage.nii.gz ${WD}/${s}/MPRAGE/t1mprage.nii.gz
	fi

	#create functional nii
	a=($(/bin/ls -d /home/despoB/lesion/data/original/dicom/${s}/*EPI*))
	ii=1
	for i in "${a[@]}"; do 
		
		if [ ! -e ${WD}/${s}/run${ii}/functional.nii.gz ]; then
			ln -s $i ${WD}/${s}/run${ii}_raw  
			mkdir ${WD}/${s}/run${ii}
			dcm2nii -o ${WD}/${s}/run${ii} ${WD}/${s}/run${ii}_raw/*dcm
			3dcopy ${WD}/${s}/run${ii}/2*.nii.gz ${WD}/${s}/run${ii}/functional.nii.gz
			rm ${WD}/${s}/run${ii}/2*.nii.gz
		fi

		ii=$(($ii+1))
	done

	#### Anatomical skullstriping
	cd ${WD}/${s}/MPRAGE
	a=($(/bin/ls /home/despoB/lesion/anat_preproc/${s}/*))

	for i in "${a[@]}"; do 
		ln -s $i 
	done

	if [ ! -e ${WD}/${s}/MPRAGE/mprage_bet.nii.gz ]; then
		antsBrainExtraction.sh -d 3 -a ${WD}/${s}/MPRAGE/t1mprage.nii.gz -e ${BRAIN_EXTRACTION_T1_TEMPLATE} \
		-m ${BRAIN_EXTRACTION_PROBABILITY_MASK_TEMPLATE} \
		-f ${WD}/${s}/MPRAGE/${s}_inverse_binary_lesion_mask_dil2.nii \
		-k 1 \
		-o ${WD}/${s}/MPRAGE/mprage_bet.nii.gz
	fi

	for mask in WM CSF; do
		if [ ! -e ${WD}/${s}/MPRAGE/${mask}_mni.nii.gz ]; then
			3dmask_tool -input mprage_bet.nii.gzBrainExtraction${mask}.nii.gz -dilate_input -2 -prefix ${mask}.nii.gz

			antsApplyTransforms -d 3 -o ${mask}_mni.nii.gz -r ${s}_quick_reg_InverseWarped.nii.gz \
			-i ${mask}.nii.gz -t ${s}_quick_reg_1InverseWarp.nii.gz -t [${s}_quick_reg_0GenericAffine.mat,1]
		fi
	done	
	

	#### funcitonal preproc
	cd ${WD}/${s}/

	for r in 1 2 3; do
	# no alignment is calcualted here. use Ants for subsequent co-registration 
		if [ -d ${WD}/${s}/run${r} ]; then

			cd ${WD}/${s}/run${r}

			if [ ! -e ${WD}/${s}/run${r}/dkmt_functional.nii.gz ]; then
				preprocessFunctional \
				-4d functional.nii.gz -tr 2 \
				-mprage_bet ${WD}/${s}/MPRAGE/mprage_bet.nii.gzBrainExtractionBrain.nii.gz \
				-compute_warp_only \
				-despike -motion_censor fd=0.5 \
				-no_hp -rescaling_method 100_voxelmean \
				-func_struc_dof bbr -smoothing_kernel 0 \
				-slice_acquisition interleaved
			fi

			### damn registration and warping 

			if [ ! -e ANTSed.nii.gz ]; then
				antsRegistrationSyNQuick.sh -d 3 -t a -f ../MPRAGE/t1mprage.nii.gz -m mt_functional_tmean.nii.gz -o affine_func_to_struct
				antsApplyTransforms -d 3 -o [transformcollaps.nii.gz, 1] -t ../MPRAGE/${s}_quick_reg_1InverseWarp.nii.gz \
				-t [../MPRAGE/${s}_quick_reg_0GenericAffine.mat, 1] -t affine_func_to_struct0GenericAffine.mat -r ../MPRAGE/${s}_quick_reg_InverseWarped.nii.gz
				ImageMath 3 4dwarp.nii.gz ReplicateDisplacement transformcollaps.nii.gz 300 2 0
				ImageMath 3 template_replicated.nii.gz ReplicateImage ../MPRAGE/${s}_quick_reg_InverseWarped.nii.gz 300 2 0
				antsApplyTransforms -d 4 -o ANTSed.nii.gz -t 4dwarp.nii.gz -r template_replicated.nii.gz -i dkmt_functional.nii.gz
			fi
			#rm 4dwarp.nii.gz
			#rm template_replicated.nii.gz

			#compcor regressors, 5 components
			3dpc -vmean -mask ../MPRAGE/CSF_mni.nii.gz -pcsave 5 -prefix CSF_PC ANTSed.nii.gz
			3dpc -vmean -mask ../MPRAGE/WM_mni.nii.gz -pcsave 5 -prefix WM_PC ANTSed.nii.gz

			#get friston 24 motion regressors
			1d_tool.py -infile motion.par -derivative -write motion_d.1d
			cp motion.par motion.par.bkup
			cp motion_d.1d motion_d.1d.bkup
			1deval -a motion.par[0] -expr 'a*a' > tmp1.1D
			1deval -a motion.par[1] -expr 'a*a' > tmp2.1D
			1deval -a motion.par[2] -expr 'a*a' > tmp3.1D
			1deval -a motion.par[3] -expr 'a*a' > tmp4.1D
			1deval -a motion.par[4] -expr 'a*a' > tmp5.1D
			1deval -a motion.par[5] -expr 'a*a' > tmp6.1D
			1deval -a motion_d.1d[0] -expr 'a*a' > tmp7.1D
			1deval -a motion_d.1d[1] -expr 'a*a' > tmp8.1D
			1deval -a motion_d.1d[2] -expr 'a*a' > tmp9.1D
			1deval -a motion_d.1d[3] -expr 'a*a' > tmp10.1D
			1deval -a motion_d.1d[4] -expr 'a*a' > tmp11.1D
			1deval -a motion_d.1d[5] -expr 'a*a' > tmp12.1D
			1dcat motion.par motion_d.1d tmp1.1D tmp2.1D tmp3.1D tmp4.1D tmp5.1D tmp6.1D tmp7.1D tmp8.1D tmp9.1D tmp10.1D tmp11.1D tmp12.1D > motion.txt

			#regression
			if [ ! -e preproc_functional.nii.gz ]; then
				3dTproject -input ANTSed.nii.gz \
				-censor motion_info/censor_union.1D \
				-ort CSF_PC_vec.1D \
				-ort WM_PC_vec.1D \
				-ort motion.txt \
				-passband 0.008 0.09 \
				-automask \
				-blur 6 \
				-prefix preproc_functional.nii.gz	
			fi

			#clean up
			rm tmp*1D 
			rm 4dwarp.nii.gz
			rm template_replicated.nii.gz
			rm _functional.nii.gz
			rm t_functional.nii.gz
			rm mc_initial.nii.gz
			rm mt_functional.nii.gz
			rm kmt*
			rm epi_bet.nii.gz
		fi
	done

done

