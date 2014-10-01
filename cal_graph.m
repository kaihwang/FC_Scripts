function  [Adj, Graph] = cal_graph(subjid)
% wrapper function to load adj matrices and do graph analyses.

%% load dataset

%loop through parcellations

n=1;
for Parcellation = 21:42
    Full_fn = strcat('/home/despo/kaihwang/Rest/AdjMatrices/t',subjid,'_full_corrmat_',num2str(Parcellation)); %full matrix
    Right_fn = strcat('/home/despo/kaihwang/Rest/AdjMatrices/t',subjid,'_Right_corrmat_',num2str(Parcellation)); %right hemi
    Left_fn = strcat('/home/despo/kaihwang/Rest/AdjMatrices/t',subjid,'_Left_corrmat_',num2str(Parcellation)); %left hemi
    
    Adj.Matrix_Full{n} = load(Full_fn);
    Adj.Matrix_Right{n} = load(Right_fn);
    Adj.Matrix_Left{n} = load(Left_fn);
    
    n=n+1;
end

%% do graph

for n = 1:length(Adj.Matrix_Full)
   M = Adj.Matrix_Full{n};
   
   i = 1;
   for T = 0.05:0.005:0.15;
      
       [Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(threshold_proportional(M,T));
       
       Graph.Full_Q{n}(i) = Q;
       Graph.Full_E{n}(i) = E;
       Graph.Full_Ci{n}(i,:) = Ci;
       
       i = i+1;       
   end
end

for n = 1:length(Adj.Matrix_Full)
   M = Adj.Matrix_Right{n};
   
   i = 1;
   for T =  0.05:0.005:0.15;
      
       [Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(threshold_proportional(M,T));
       
       Graph.Right_Q{n}(i) = Q;
       Graph.Right_E{n}(i) = E;
       Graph.Right_Ci{n}(i,:) = Ci;
       
       i = i+1;       
   end
end

for n = 1:length(Adj.Matrix_Full)
   M = Adj.Matrix_Left{n};
   
   i = 1;
   for T = 0.05:0.005:0.15;
      
       [Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(threshold_proportional(M,T));
       
       Graph.Left_Q{n}(i) = Q;
       Graph.Left_E{n}(i) = E;
       Graph.Left_Ci{n}(i,:) = Ci;
       
       i = i+1;       
   end
end
