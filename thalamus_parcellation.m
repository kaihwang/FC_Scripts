% script to parcellate thalamsu

load /home/despoB/kaihwang/Rest/Thalamic_parcel/AveAdjM.mat

%declare output structures
Thalamic_target = zeros(length(thalamus_ROI_vector), 1+length(WashU333_ROI_vector));
Thalamic_target_CI = zeros(length(thalamus_ROI_vector), 1+length(WashU333_ROI_vector));
connectivity_vector = zeros(1,length(WashU333_ROI_vector));

for Thalamic_voxel = 1:length(thalamus_ROI_vector);
	for Cortical_roi = 1:length(WashU333_ROI_vector);

		%find the thalamus voxel index in the thalamocortical adj matrix
		i_thalamus = find(thalamocortical_ROI_vector==thalamus_ROI_vector(Thalamic_voxel));
		
		%find the cortical ROI index in the thalamocortical adj matrix
		i_cortical = find(thalamocortical_ROI_vector==WashU333_ROI_vector(Cortical_roi));

		%extract thalamo-cortical connectivity values
		connectivity_vector(Cortical_roi) = AveAdjM(i_thalamus, i_cortical);

	end
	%take out NANs
	connectivity_vector(isnan(connectivity_vector))=-inf;

	% rank the ROIs based on its connectivity strength, sort them decreasing
	[~,ROI_rank]=sort(connectivity_vector, 'descend');

	% save the sorted ROIs as well as the community assignemnt
	Thalamic_target(Thalamic_voxel, 1) = thalamus_ROI_vector(Thalamic_voxel);
	Thalamic_target(Thalamic_voxel, 2:1+length(ROI_rank)) = ROI_rank;
	Thalamic_target_CI(Thalamic_voxel, 1) = thalamus_ROI_vector(Thalamic_voxel);
	Thalamic_target_CI(Thalamic_voxel, 2:1+length(ROI_rank)) = WashU333ROI_CI(ROI_rank); 
end