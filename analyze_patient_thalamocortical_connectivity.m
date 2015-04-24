% script to analyze patients thalamic cortical target weight change. 

load /home/despoB/kaihwang/Rest/Thalamic_parcel/Thalamus_voxel_CorticalTarget_plus_parcellation.mat
load /home/despoB/kaihwang/Rest/ROIs/WashU333_Communities.mat
%cd /home/despoB/kaihwang/Rest/Graph/
%Connectome_Subj = load('/home/despoB/connectome-thalamus/connectome/list_of_complete_subjects');
%Connectome_Subj = Connectome_Subj';
%Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220]; %young folks
Control_Subj = [1103 1220 1306 1223 1314 1311 1318 1313 1326 1325 1328 1329 1333 1331 1335 1338 1336 1339 1337 1344 1340];



Output=[];

NumROIs = 1;%round(323*.05);
Patient_Degree=[];
Patient_Intact_Degree=[];
Patient_wDegree= [];
Patient_Intact_wDegree= [];

Patient_bDegree= [];
Patient_Intact_bDegree= [];

Patient_CC= [];
Patient_Intact_CC= [];

Patient_P= [];
Patient_Intact_P= [];

Output{1,1} = 'Subject';
Output{1,2} = 'Density';
Output{1,3} = 'Cortical_Target_Degree';
Output{1,4} = 'Cortical_nonTarget_Degree';
Output{1,5} = 'Cortical_Target_Within_Degree';
Output{1,6} = 'Cortical_nonTarget_Within_Degree';
Output{1,7} = 'Cortical_Target_Between_Degree';
Output{1,8} = 'Cortical_nonTarget_Between_Degree';
Output{1,9} = 'Cortical_Target_Weight';
Output{1,10} = 'Cortical_nonTarget_Weight';
Output{1,11} = 'Cortical_Target_Within_Weight';
Output{1,12} = 'Cortical_nonTarget_Within_Weight';
Output{1,13} = 'Cortical_Target_Between_Weight';
Output{1,14} = 'Cortical_nonTarget_Between_Weight';
Output{1,15} = 'Cortical_Target_PC';
Output{1,16} = 'Cortical_nonTarget_PC';


Patient_Cortical_Target={};
n=1;
row = 2;
for patients = [128, 162, 163, 168, 176]; % loop through thalamic patients
	

	
	%load their graph analysis output plus the lesion voxel mas
	fn = strcat('/home/despoB/kaihwang/Rest/Graph/gsetCI_',num2str(patients),'.mat');
	
	%% this part is now being replaced by python...

	% load(fn);
	% fn = strcat('/home/despoB/kaihwang/Rest/Lesion_Masks/',num2str(patients),'_lesioned_voxels');
	
	% lesioned_thalamus_voxel = load(fn);
	% lesioned_thalamus_voxel(:,1:3)=[];

	% %for each lesioned voxel, compile a list of targeted ROIs 
	% Targeted_ROIs = [];
	% nonTargeted_ROIs = [];
	% Targeted_ROICI = [];
	% nonTargeted_ROICI = [];

	% for voxel = 1:length(lesioned_thalamus_voxel)

	% 	%match the ROI label in the two vectors, find the index
	% 	i_thalamus = find(lesioned_thalamus_voxel(voxel)==Thalamic_target(:,1)); 

	% 	%after finding the idex, extract the ROI label corresponding to that index!
	% 	Targeted_ROIs = [Targeted_ROIs, Thalamic_target(i_thalamus, 2:1+NumROIs)];
	% 	nonTargeted_ROIs = [nonTargeted_ROIs, Thalamic_target(i_thalamus, end-NumROIs:end)];	
	% 	Targeted_ROICI = [Targeted_ROICI, Thalamic_target_CI(i_thalamus, 2:1+NumROIs)];
	% 	nonTargeted_ROICI = [nonTargeted_ROICI, Thalamic_target_CI(i_thalamus, end-NumROIs:end)];	
	% end

	% %sort out overlapping ROI labels!
	% Targeted_ROIs = unique(Targeted_ROIs);
	% nonTargeted_ROIs = unique(nonTargeted_ROIs);

	fn = strcat('/home/despoB/kaihwang/bin/FuncParcel/',num2str(patients),'_cortical_target');
	Targeted_ROIs = load(fn);
	fn = strcat('/home/despoB/kaihwang/bin/FuncParcel/',num2str(patients),'_cortical_nontarget');
	nonTargeted_ROIs = load(fn);
	fn = strcat('/home/despoB/kaihwang/bin/FuncParcel/Cortical_ROI_index');
	ROIID = load(fn);
	% now, need to convert label to index again!!
	Targeted_ROI_index =[];
	for roi = 1:length(Targeted_ROIs)
		if ~ isempty(find(Targeted_ROIs(roi) == ROIID))
			Targeted_ROI_index(roi) = find(Targeted_ROIs(roi) == ROIID);
		end
	end
	Targeted_ROI_index(Targeted_ROI_index==0)=[]; 


	Intact_ROI_index = []; %setdiff([1:323], Targeted_ROI_index);
	for roi = 1:length(nonTargeted_ROIs)
		if ~ isempty(find(nonTargeted_ROIs(roi) == ROIID))
			Intact_ROI_index(roi) = find(nonTargeted_ROIs(roi) == ROIID);
		end
	end
	Intact_ROI_index(Intact_ROI_index==0)=[]; 

	%save the cortical Target info (roi number, CI...)
	Patient_Cortical_Target{n}.Targeted_ROIs = Targeted_ROIs;
	Patient_Cortical_Target{n}.nonTargeted_ROIs = nonTargeted_ROIs;
	%Patient_Cortical_Target{n}.Targeted_ROICI = Targeted_ROICI;
	%Patient_Cortical_Target{n}.nonTargeted_ROICI = nonTargeted_ROICI;

	%extract weight
	Patient_Degree(n,:) = nanmean(Graph.Degree{1}(:,Targeted_ROI_index)');
	Patient_Intact_Degree(n,:) = nanmean(Graph.Degree{1}(:,Intact_ROI_index)');

	Patient_wDegree(n,:) = nanmean(Graph.Within_Module_Degree{1}(:,Targeted_ROI_index)');
	Patient_Intact_wDegree(n,:) = nanmean(Graph.Within_Module_Degree{1}(:,Intact_ROI_index)');

	Patient_bDegree(n,:) = nanmean(Graph.Out_Module_Degree{1}(:,Targeted_ROI_index)');
	Patient_Intact_bDegree(n,:) = nanmean(Graph.Out_Module_Degree{1}(:,Intact_ROI_index)');

	Patient_CC(n,:) = nanmean(Graph.Full_CC{1}(:,Targeted_ROI_index)');
	Patient_Intact_CC(n,:) = nanmean(Graph.Full_CC{1}(:,Intact_ROI_index)');

	Patient_Weight(n,:) = nanmean(Graph.Weight{1}(:,Targeted_ROI_index)');
	Patient_Intact_Weight(n,:) = nanmean(Graph.Weight{1}(:,Intact_ROI_index)');

	Patient_wWeight(n,:) = nanmean(Graph.Within_Module_Weight{1}(:,Targeted_ROI_index)');
	Patient_Intact_wWeight(n,:) = nanmean(Graph.Within_Module_Weight{1}(:,Intact_ROI_index)');

	Patient_bWeight(n,:) = nanmean(Graph.Out_Module_Weight{1}(:,Targeted_ROI_index)');
	Patient_Intact_bWeight(n,:) = nanmean(Graph.Out_Module_Weight{1}(:,Intact_ROI_index)');

	Patient_P(n,:) = nanmean(Graph.P{1}(:,Targeted_ROI_index)');
	Patient_Intact_P(n,:) = nanmean(Graph.P{1}(:,Intact_ROI_index)');

	
	%do controls
	Control_Degree=[];
	Control_Intact_Degree=[];
	Control_wDegree= []; 
	Control_Intact_wDegree=[];
	Control_bDegree= [];
	Control_Intact_bDegree= [];
	Control_Weight=[];
	Control_Intact_Weight=[];
	Control_wWeight= []; 
	Control_Intact_wWeight=[];
	Control_bWeight= [];
	Control_Intact_bWeight= [];
	Control_CC= [];
	Control_Intact_CC= [];
	Control_P= [];
	Control_Intact_P= [];

	i = 1;
	for controls = Control_Subj;
	
		fn = strcat('/home/despoB/kaihwang/Rest/Graph/gsetCI_',num2str(controls),'.mat');
		
		load(fn);
		
		Control_Degree(i,:) = nanmean(Graph.Degree{1}(:,Targeted_ROI_index)');
		Control_Intact_Degree(i,:)= nanmean(Graph.Degree{1}(:,Intact_ROI_index)');
		
		Control_wDegree(i,:) = nanmean(Graph.Within_Module_Degree{1}(:,Targeted_ROI_index)');
		Control_Intact_wDegree(i,:) = nanmean(Graph.Within_Module_Degree{1}(:,Intact_ROI_index)');

		Control_bDegree(i,:) = nanmean(Graph.Out_Module_Degree{1}(:,Targeted_ROI_index)');
		Control_Intact_bDegree(i,:) = nanmean(Graph.Out_Module_Degree{1}(:,Intact_ROI_index)');

		Control_Weight(i,:) = nanmean(Graph.Weight{1}(:,Targeted_ROI_index)');
		Control_Intact_Weight(i,:)= nanmean(Graph.Weight{1}(:,Intact_ROI_index)');
		
		Control_wWeight(i,:) = nanmean(Graph.Within_Module_Weight{1}(:,Targeted_ROI_index)');
		Control_Intact_wWeight(i,:) = nanmean(Graph.Within_Module_Weight{1}(:,Intact_ROI_index)');

		Control_bWeight(i,:) = nanmean(Graph.Out_Module_Weight{1}(:,Targeted_ROI_index)');
		Control_Intact_bWeight(i,:) = nanmean(Graph.Out_Module_Weight{1}(:,Intact_ROI_index)');

		Control_CC(i,:) = nanmean(Graph.Full_CC{1}(:,Targeted_ROI_index)');
		Control_Intact_CC(i,:) = nanmean(Graph.Full_CC{1}(:,Intact_ROI_index)');
	
		Control_P(i,:) = nanmean(Graph.P{1}(:,Targeted_ROI_index)');
		Control_Intact_P(i,:) = nanmean(Graph.P{1}(:,Intact_ROI_index)');

	
		i=i+1;
	end


	%create R data strcuture
	D=0.01:0.005:0.25;
	for densities = 1:length(D)
		Output{row,1} = num2str(patients);
		Output{row,2} = D(densities);
		Output{row,3} = (Patient_Degree(n,densities)-nanmean(Control_Degree(:,densities)))./nanstd(Control_Degree(:,densities));
		Output{row,4} = (Patient_Intact_Degree(n,densities)-nanmean(Control_Intact_Degree(:,densities)))./nanstd(Control_Intact_Degree(:,densities));
		Output{row,5} = (Patient_wDegree(n,densities)-nanmean(Control_wDegree(:,densities)))./nanstd(Control_wDegree(:,densities));
		Output{row,6} = (Patient_Intact_wDegree(n,densities)-nanmean(Control_Intact_wDegree(:,densities)))./nanstd(Control_Intact_wDegree(:,densities));
		Output{row,7} = (Patient_bDegree(n,densities)-nanmean(Control_bDegree(:,densities)))./nanstd(Control_bDegree(:,densities));
		Output{row,8} = (Patient_Intact_bDegree(n,densities)-nanmean(Control_Intact_bDegree(:,densities)))./nanstd(Control_Intact_bDegree(:,densities));
		Output{row,9} = (Patient_Weight(n,densities)-nanmean(Control_Weight(:,densities)))./nanstd(Control_Weight(:,densities));
		Output{row,10} = (Patient_Intact_Weight(n,densities)-nanmean(Control_Intact_Weight(:,densities)))./nanstd(Control_Intact_Weight(:,densities));
		Output{row,11} = (Patient_wWeight(n,densities)-nanmean(Control_wWeight(:,densities)))./nanstd(Control_wWeight(:,densities));
		Output{row,12} = (Patient_Intact_wWeight(n,densities)-nanmean(Control_Intact_wWeight(:,densities)))./nanstd(Control_Intact_wWeight(:,densities));
		Output{row,13} = (Patient_bWeight(n,densities)-nanmean(Control_bWeight(:,densities)))./nanstd(Control_bWeight(:,densities));
		Output{row,14} = (Patient_Intact_bWeight(n,densities)-nanmean(Control_Intact_bWeight(:,densities)))./nanstd(Control_Intact_bWeight(:,densities));
		Output{row,15} = (Patient_P(n,densities)-nanmean(Control_P(:,densities)))./nanstd(Control_P(:,densities));
		Output{row,16} = (Patient_Intact_P(n,densities)-nanmean(Control_Intact_P(:,densities)))./nanstd(Control_Intact_P(:,densities));
		row = row+1;
	end	


    n = n+1;
end