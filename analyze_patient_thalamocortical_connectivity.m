% script to analyze patients thalamic cortical target weight change. 

load /home/despoB/kaihwang/Rest/Thalamic_parcel/Thalamus_voxel_CorticalTarget_plus_parcellation.mat
%cd /home/despoB/kaihwang/Rest/Graph/
%Connectome_Subj = load('/home/despoB/connectome-thalamus/connectome/list_of_complete_subjects');
%Connectome_Subj = Connectome_Subj';
Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220];

Output=[];

NumROIs = 15;%round(323*.05);
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

n=1;
row = 2;
for patients = [128, 162, 163, 168, 176]; % loop through thalamic patients
	
	%load their graph analysis output plus the lesion voxel mas
	fn = strcat('gsetCI_',num2str(patients),'.mat');
	load(fn);
	fn = strcat('/home/despoB/kaihwang/Rest/Lesion_Masks/','lesioned_voxels_',num2str(patients));
	
	lesioned_thalamus_voxel = load(fn);
	lesioned_thalamus_voxel(:,1:3)=[];

	%for each lesioned voxel, compile a list of targeted ROIs 
	Targeted_ROIs = [];
	for voxel = 1:length(lesioned_thalamus_voxel)

		%match the ROI label in the two vectors, find the index
		i_thalamus = find(lesioned_thalamus_voxel(voxel)==Thalamic_target(:,1)); 

		%after finding the idex, extract the ROI label corresponding to that index!
		Targeted_ROIs = [Targeted_ROIs, Thalamic_target(i_thalamus, 2:1+NumROIs)];	
	end

	%sort out overlapping ROI labels!
	Targeted_ROIs = unique(Targeted_ROIs);
	
	% now, need to convert label to index again!!
	Targeted_ROI_index =[];
	for roi = 1:length(Targeted_ROIs)
		Targeted_ROI_index(roi) = find(Targeted_ROIs(roi) == WashU333_ROI_vector);
	end
	Intact_ROI_index = setdiff([1:323], Targeted_ROI_index);

	%extract weight
	Patient_Degree(n,:) = nanmean(Graph.Degree{1}(:,Targeted_ROI_index)');
	Patient_Intact_Degree(n,:) = nanmean(Graph.Degree{1}(:,Intact_ROI_index)');

	Patient_wDegree(n,:) = nanmean(Graph.Within_Module_Degree{1}(:,Targeted_ROI_index)');
	Patient_Intact_wDegree(n,:) = nanmean(Graph.Within_Module_Degree{1}(:,Intact_ROI_index)');

	Patient_bDegree(n,:) = nanmean(Graph.Out_Module_Degree{1}(:,Targeted_ROI_index)');
	Patient_Intact_bDegree(n,:) = nanmean(Graph.Out_Module_Degree{1}(:,Intact_ROI_index)');

	Patient_CC(n,:) = nanmean(Graph.Full_CC{1}(:,Targeted_ROI_index)');
	Patient_Intact_CC(n,:) = nanmean(Graph.Full_CC{1}(:,Intact_ROI_index)');

	Patient_P(n,:) = nanmean(Graph.P{1}(:,Targeted_ROI_index)');
	Patient_Intact_P(n,:) = nanmean(Graph.P{1}(:,Intact_ROI_index)');

	
	%do controls
	i = 1;
	Control_Degree=[];
	Control_Intact_Degree=[];
	Control_wDegree= []; 
	Control_Intact_wDegree=[];

	Control_bDegree= [];
	Control_Intact_bDegree= [];
	Control_CC= [];
	Control_Intact_CC= [];

	Control_P= [];
	Control_Intact_P= [];
	for controls = Control_Subj;
	
		fn = strcat('gsetCI_',num2str(controls),'.mat');
		load(fn);
		Control_Degree(i,:) = nanmean(Graph.Degree{1}(:,Targeted_ROI_index)');
		Control_Intact_Degree(i,:)= nanmean(Graph.Degree{1}(:,Intact_ROI_index)');
		Control_wDegree(i,:) = nanmean(Graph.Within_Module_Degree{1}(:,Targeted_ROI_index)');
		Control_Intact_wDegree(i,:) = nanmean(Graph.Within_Module_Degree{1}(:,Intact_ROI_index)');

		Control_bDegree(i,:) = nanmean(Graph.Out_Module_Degree{1}(:,Targeted_ROI_index)');
		Control_Intact_bDegree(i,:) = nanmean(Graph.Out_Module_Degree{1}(:,Intact_ROI_index)');

		Control_CC(i,:) = nanmean(Graph.Full_CC{1}(:,Targeted_ROI_index)');
		Control_Intact_CC(i,:) = nanmean(Graph.Full_CC{1}(:,Intact_ROI_index)');
	
		Control_P(i,:) = nanmean(Graph.P{1}(:,Targeted_ROI_index)');
		Control_Intact_P(i,:) = nanmean(Graph.P{1}(:,Intact_ROI_index)');

	
		i=i+1;
	end


	%create R data strcuture
	D=0.05:0.005:0.25;
	for densities = 1:length(D)
		Output{row,1} = num2str(patients);
		Output{row,2} = D(densities);
		Output{row,3} = (Patient_Degree(n,densities)-mean(Control_Degree(:,densities)))./std(Control_Degree(:,densities));
		Output{row,4} = (Patient_Intact_Degree(n,densities)-mean(Control_Intact_Degree(:,densities)))./std(Control_Intact_Degree(:,densities));
		Output{row,5} = (Patient_wDegree(n,densities)-mean(Control_wDegree(:,densities)))./std(Control_wDegree(:,densities));
		Output{row,6} = (Patient_Intact_wDegree(n,densities)-mean(Control_Intact_wDegree(:,densities)))./std(Control_Intact_wDegree(:,densities));
		Output{row,7} = (Patient_bDegree(n,densities)-mean(Control_bDegree(:,densities)))./std(Control_bDegree(:,densities));
		Output{row,8} = (Patient_Intact_bDegree(n,densities)-mean(Control_Intact_bDegree(:,densities)))./std(Control_Intact_bDegree(:,densities));
		row = row+1;
	end	
	%figure
	%H1=shadedErrorBar(0.05:0.005:0.25,Control_Weights,{@nanmean, @nanstd},{'-','LineWidth',3,'Color',rgb('gray')},0);
    %hold on;
    %H2=plot(0.05:0.005:0.25,Patient_Wegihts(n,:),'linewidth',3,'color','k');
    %H9=plot(T,squeeze(Modularity_tha(t,:,:)),'linewidth',3,'color','b');
    %H2=shadedErrorBar(T,squeeze(Modularity_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    %H3=shadedErrorBar(T,squeeze(Modularity_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('green')},1);
    %hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    %xlim([0.05 0.25])
    %ylim([0.25 0.65])
   	%set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    %set(hl,'FontSize', 12, 'Box','off');
    %xlabel('Cost','FontSize',14)
    %ylabel('Modularity','FontSize',14)
    %title('Targeted ROIs','FontSize',16)
    %set(gcf, 'Color', 'white');
    %fn = strcat('Modularity_',num2str(t),'.png');

    %figure
	%H1=shadedErrorBar(0.05:0.005:0.25,Control_Intact_Weights,{@nanmean, @nanstd},{'-','LineWidth',3,'Color',rgb('gray')},0);
    %hold on;
    %H2=plot(0.05:0.005:0.25,Patient_Intact_Weights(n,:),'linewidth',3,'color','k');
    %H9=plot(T,squeeze(Modularity_tha(t,:,:)),'linewidth',3,'color','b');
    %H2=shadedErrorBar(T,squeeze(Modularity_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    %H3=shadedErrorBar(T,squeeze(Modularity_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('green')},1);
    %hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    %xlim([0.05 0.25])
    %ylim([0.25 0.65])
    %set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    %set(hl,'FontSize', 12, 'Box','off');
    %xlabel('Cost','FontSize',14)
    %ylabel('Modularity','FontSize',14)
    %title('Spared ROIs','FontSize',16)
    %set(gcf, 'Color', 'white');
    %fn = strcat('Modularity_',num2str(t),'.png');

    n = n+1;
end