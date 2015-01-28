% script to calculate mutual information between patients and controls

Connectome_Subj = load('/home/despoB/connectome-thalamus/connectome/list_of_complete_subjects');
Connectome_Subj = Connectome_Subj';
Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220];
Tha_Subj = [128 162 163 168 176];
BG_Subj =  [116 117 144 121 122 143 138 153];

load /home/despoB/kaihwang/Rest/ROIs/WashU333_Communities.mat

Groups ={{Connectome_Subj},{Control_Subj},{Tha_Subj},{BG_Subj}};
GroupName = {'Connectome','Young_Controls','Thalamic_Patients','Striatal_Patients'};

Output = {};
Output{1,1} = 'Group';
Output{1,2} = 'Subject';
Output{1,3} = 'Measure';
Output{1,4} = 'Value';
row = 2;
for g = 1:length(Groups);
	sublist = cell2mat(Groups{g});
    s=[];
    NMI{g}=[];

    for s = sublist
    	if g == 4 %#ok<ALIGN>
			load(strcat('/home/despoB/kaihwang/Rest/Graph/gsetCI_b',num2str(s),'.mat'));
			subID = strcat('b',num2str(s));
        	
        elseif g~=4
    		load(strcat('/home/despoB/kaihwang/Rest/Graph/gsetCI_',num2str(s),'.mat'));
    		subID = num2str(s);
        end

        if g ==1
        	mi = calNMI(Graph.Full_Ci{1}(11,:),WashU325ROI_CI');
        elseif g~=1
        	mi = calNMI(Graph.Full_Ci{1}(11,:),WashU333ROI_CI');
        end

        Output{row,1} = GroupName{g};
    	Output{row,2} = subID;
        Output{row,3} = 'NMI';
        Output{row,4} = mi;
        row = row+1;
    end


end