%% load datas

%control
Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220];
Tha_Subj = [128 162 163 168 176];

s=1;
for sub = Control_Subj
    fn = strcat('/home/despo/kaihwang/Rest/Graph/g_',num2str(sub),'.mat');
    load (fn);
    
    for p = 1: length(Graph.Full_Q)
        Modularity_Control(p,s,:) = Graph.Full_Q{p};
        Modularity_Control_R(p,s,:) = Graph.Right_Q{p};
        Modularity_Control_L(p,s,:) = Graph.Left_Q{p};
        
        Efficiency_Control(p,s,:) = Graph.Full_E{p};
        Efficiency_Control_R(p,s,:) = Graph.Right_E{p};
        Efficiency_Control_L(p,s,:) = Graph.Left_E{p};
        Adj_Control{p}(s,:,:) = Adj.Matrix_Full{p};
        Adj_Control_R{p}(s,:,:) = Adj.Matrix_Right{p};
        Adj_Control_L{p}(s,:,:) = Adj.Matrix_Left{p};
        
    end
    
    s=s+1;
end


s=1;
for sub = Tha_Subj
    fn = strcat('/home/despo/kaihwang/Rest/Graph/g_',num2str(sub),'.mat');
    load (fn);
    
    for p = 1: length(Graph.Full_Q)
        Modularity_tha(p,s,:) = Graph.Full_Q{p};
        Modularity_tha_R(p,s,:) = Graph.Right_Q{p};
        Modularity_tha_L(p,s,:) = Graph.Left_Q{p};
        
        Efficiency_tha(p,s,:) = Graph.Full_E{p};
        Efficiency_tha_R(p,s,:) = Graph.Right_E{p};
        Efficiency_tha_L(p,s,:) = Graph.Left_E{p};
        
        Adj_Tha{p}(s,:,:) = Adj.Matrix_Full{p};
        Adj_Tha_R{p}(s,:,:) = Adj.Matrix_Right{p};
        Adj_Tha_L{p}(s,:,:) = Adj.Matrix_Left{p};
        
    end
    
    s=s+1;
end


