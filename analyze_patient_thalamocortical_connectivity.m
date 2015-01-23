% script to analyze patients thalamic cortical target weight change. 

load /home/despoB/kaihwang/Rest/Thalamic_parcel/Thalamus_voxel_CorticalTarget_plus_parcellation.mat
cd /home/despoB/kaihwang/Rest/Graph/
%Control_Subj = load('/home/despoB/connectome-thalamus/connectome/list_of_complete_subjects');
%Control_Subj = Control_Subj';
Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220];


NumROIs = 6%round(323*.05);
Patient_Wegihts=[];
Patient_Intact_Weights=[];


n=1;
for patients = [128, 162, 163, 168, 176]; % loop through thalamic patients
	
	%load their graph analysis output plus the lesion voxel mas
	fn = strcat('g_',num2str(patients),'.mat');
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
	Patient_Wegihts(n,:) = nanmean(Graph.Weight{1}(:,Targeted_ROI_index)');
	Patient_Intact_Weights(n,:) = nanmean(Graph.Weight{1}(:,Intact_ROI_index)');
	
	%do controls
	i = 1;
	Control_Weights=[];
	Control_Intact_Weights=[];
	for controls = Control_Subj;
	
		fn = strcat('g_',num2str(controls),'.mat');
		load(fn);
		Control_Weights(i,:) = nanmean(Graph.Weight{1}(:,Targeted_ROI_index)');
		Control_Intact_Weights(i,:)= nanmean(Graph.Weight{1}(:,Intact_ROI_index)');
	
		i=i+1;
	end

	figure
	H1=shadedErrorBar(0.05:0.005:0.25,Control_Weights,{@nanmean, @nanstd},{'-','LineWidth',3,'Color',rgb('gray')},0);
    hold on;
    H2=plot(0.05:0.005:0.25,Patient_Wegihts(n,:),'linewidth',3,'color','k');
    %H9=plot(T,squeeze(Modularity_tha(t,:,:)),'linewidth',3,'color','b');
    %H2=shadedErrorBar(T,squeeze(Modularity_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    %H3=shadedErrorBar(T,squeeze(Modularity_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('green')},1);
    %hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    %xlim([0.05 0.25])
    %ylim([0.25 0.65])
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    %set(hl,'FontSize', 12, 'Box','off');
    %xlabel('Cost','FontSize',14)
    %ylabel('Modularity','FontSize',14)
    title('Targeter ROIs','FontSize',16)
    set(gcf, 'Color', 'white');
    %fn = strcat('Modularity_',num2str(t),'.png');

    figure
	H1=shadedErrorBar(0.05:0.005:0.25,Control_Intact_Weights,{@nanmean, @nanstd},{'-','LineWidth',3,'Color',rgb('gray')},0);
    hold on;
    H2=plot(0.05:0.005:0.25,Patient_Intact_Weights(n,:),'linewidth',3,'color','k');
    %H9=plot(T,squeeze(Modularity_tha(t,:,:)),'linewidth',3,'color','b');
    %H2=shadedErrorBar(T,squeeze(Modularity_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    %H3=shadedErrorBar(T,squeeze(Modularity_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('green')},1);
    %hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    %xlim([0.05 0.25])
    %ylim([0.25 0.65])
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    %set(hl,'FontSize', 12, 'Box','off');
    %xlabel('Cost','FontSize',14)
    %ylabel('Modularity','FontSize',14)
    title('Spared ROIs','FontSize',16)
    set(gcf, 'Color', 'white');
    %fn = strcat('Modularity_',num2str(t),'.png');

    n = n+1;
end