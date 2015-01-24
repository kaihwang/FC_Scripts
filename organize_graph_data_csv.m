%script to organize graph outputs into R's dataframe structure (writing a cell array to csv)

% load subjects

Connectome_Subj = load('/home/despoB/connectome-thalamus/connectome/list_of_complete_subjects');
Connectome_Subj = Connectome_Subj';
Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220];
Tha_Subj = [128 162 163 168 176];
BG_Subj =  [116 117 144 121 122 143 138 153];
Densities = 0.05:0.005:0.25;

Groups ={{Connectome_Subj},{Control_Subj},{Tha_Subj},{BG_Subj}};
GroupName = {'Connectome','Young_Controls','Thalamic_Patients','Striatal_Patients'};
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

% loop through groups then append rows
row = 2;
for g = 1:length(Groups);
	subjects = squeeze(Groups{g});

	for s = subjects{1}
		for d = 1:length(Densities)
			%load data
			if g == 4
				load(strcat('/home/despoB/kaihwang/Rest/Graph/gsetCI_b',num2str(s),'.mat'));
				subID = strcat('b',num2str(s));
    		else
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

			row = row+1;
		end
	end
end

