%script to organize graph outputs into R's dataframe structure (writing a cell array to csv)

% load subjects

Connectome_Subj = load('/home/despoB/connectome-thalamus/connectome/list_of_complete_subjects');
Connectome_Subj = Connectome_Subj';
Young_Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 219 220]; %young
Older_Control_Subj = [1103 1220 1306 1223 1314 1311 1318 1313 1326 1325 1328 1329 1333 1331 1335 1338 1336 1339 1337 1344 1340];
Tha_Subj = [128 162 163 168 176];
BG_Subj =  [117 122 138 143 153];
Older_Subj = [ ];
Densities = 0.01:0.005:0.25;

Groups ={{Young_Control_Subj},{Older_Control_Subj},{Tha_Subj},{BG_Subj}};
GroupName = {'Young_Controls','Older_Controls','Thalamic_Patients','Striatal_Patients'};
DataFrame = {};

%scpecify variable names at row 1
DataFrame{1,1} = 'Group';
DataFrame{1,2} = 'Subject';
DataFrame{1,3} = 'Density';
DataFrame{1,4} = 'Modularity';
DataFrame{1,5} = 'Modulairty_Left_Hemisphere';
DataFrame{1,6} = 'Modularity_Right_Hemisphere';
DataFrame{1,7} = 'Clustering_Coefficient';
DataFrame{1,8} = 'Clustering_Coefficient_Left_Hemisphere';
DataFrame{1,9} = 'Clustering_Coefficeint_Right_Hemisphere';
DataFrame{1,10} = 'Weight';
DataFrame{1,11} = 'Weight_Left_Hemisphere';
DataFrame{1,12} = 'Weight_Right_Hemisphere';
DataFrame{1,13} = 'PosWeight';
DataFrame{1,14} = 'PosWeight_Left_Hemisphere';
DataFrame{1,15} = 'PosWeight_Right_Hemisphere';
DataFrame{1,16} = 'NegWeight';
DataFrame{1,17} = 'NegWeight_Left_Hemisphere';
DataFrame{1,18} = 'NegWeight_Right_Hemisphere';
DataFrame{1,19} = 'Global_Efficiency';
DataFrame{1,20} = 'Global_Efficiency_Left_Hemisphere';
DataFrame{1,21} = 'Global_Efficiency_Right_Hemisphere';
DataFrame{1,22} = 'Local_Efficiency';
DataFrame{1,23} = 'Local_Efficiency_Left_Hemisphere';
DataFrame{1,24} = 'Local_Efficiency_Right_Hemisphere';
DataFrame{1,25} = 'Within_Module_Degree';
DataFrame{1,26} = 'Within_Module_Degree_Left_Hemisphere';
DataFrame{1,27} = 'Within_Module_Degree_Right_Hemisphere';
DataFrame{1,28} = 'Within_Module_Weight';
DataFrame{1,29} = 'Within_Module_Weight_Left_Hemisphere';
DataFrame{1,30} = 'Within_Module_Weight_Right_Hemisphere';
DataFrame{1,31} = 'Out_Module_Degree';
DataFrame{1,32} = 'Out_Module_Degree_Left_Hemisphere';
DataFrame{1,33} = 'Out_Module_Degree_Right_Hemisphere';
DataFrame{1,34} = 'Out_Module_Weight';
DataFrame{1,35} = 'Out_Module_Weight_Left_Hemisphere';
DataFrame{1,36} = 'Out_Module_Weight_Right_Hemisphere';

% loop through groups then append rows
row = 2;
for g = 1:length(Groups);
	sublist = cell2mat(Groups{g});
    s=[];
	for s = sublist
		for d = 1:length(Densities)
			%load data
			if g == 4 %#ok<ALIGN>
				load(strcat('/home/despoB/kaihwang/Rest/Graph/gsetCI_b',num2str(s),'.mat'));
				subID = strcat('b',num2str(s));
            elseif g ~= 4
    			load(strcat('/home/despoB/kaihwang/Rest/Graph/gsetCI_',num2str(s),'.mat'));
    			subID = num2str(s);
            end
            
    		DataFrame{row,1} = GroupName{g};
    		DataFrame{row,2} = subID;
    		DataFrame{row,3} = Densities(d);
    		DataFrame{row,4} = Graph.Full_Q{1}(d);
    		DataFrame{row,5} = Graph.Left_Q{1}(d);
    		DataFrame{row,6} = Graph.Right_Q{1}(d);
    		DataFrame{row,7} = nanmean(Graph.Full_CC{1}(d,:));
    		DataFrame{row,8} = nanmean(Graph.Left_CC{1}(d,:));
			DataFrame{row,9} = nanmean(Graph.Right_CC{1}(d,:));
			DataFrame{row,10} = nanmean(Graph.Weight{1}(d,:));
			DataFrame{row,11} = nanmean(Graph.Left_Weight{1}(d,:));
			DataFrame{row,12} = nanmean(Graph.Right_Weight{1}(d,:));
			DataFrame{row,13} = nanmean(Graph.Pos_Weight{1}(d,:));
			DataFrame{row,14} = nanmean(Graph.Left_Pos_Weight{1}(d,:));
			DataFrame{row,15} = nanmean(Graph.Right_Pos_Weight{1}(d,:));
			DataFrame{row,16} = nanmean(Graph.Neg_Weight{1}(d,:));
			DataFrame{row,17} = nanmean(Graph.Left_Neg_Weight{1}(d,:));
			DataFrame{row,18} = nanmean(Graph.Right_Neg_Weight{1}(d,:));
			DataFrame{row,19} = Graph.Full_E{1}(d);
			DataFrame{row,20} = Graph.Left_E{1}(d);
			DataFrame{row,21} = Graph.Right_E{1}(d);
			DataFrame{row,22} = nanmean(Graph.Full_locE{1}(d,:));
			DataFrame{row,23} = nanmean(Graph.Left_locE{1}(d,:));
			DataFrame{row,24} = nanmean(Graph.Right_locE{1}(d,:));
			DataFrame{row,25} = nanmean(Graph.Within_Module_Degree{1}(d,:));
			DataFrame{row,26} = nanmean(Graph.Left_Within_Module_Degree{1}(d,:));
			DataFrame{row,27} = nanmean(Graph.Right_Within_Module_Degree{1}(d,:));
			DataFrame{row,28} = nanmean(Graph.Within_Module_Weight{1}(d,:));
			DataFrame{row,29} = nanmean(Graph.Left_Within_Module_Weight{1}(d,:));
			DataFrame{row,30} = nanmean(Graph.Right_Within_Module_Weight{1}(d,:));
			DataFrame{row,31} = nanmean(Graph.Out_Module_Degree{1}(d,:));
			DataFrame{row,32} = nanmean(Graph.Left_Out_Module_Degree{1}(d,:));
			DataFrame{row,33} = nanmean(Graph.Right_Out_Module_Degree{1}(d,:));
			DataFrame{row,34} = nanmean(Graph.Out_Module_Weight{1}(d,:));
			DataFrame{row,35} = nanmean(Graph.Left_Out_Module_Weight{1}(d,:));
			DataFrame{row,36} = nanmean(Graph.Right_Out_Module_Weight{1}(d,:));

			row = row+1;
		end
	end
end

