function  [Adj, Graph] = cal_graph(subjid)
% wrapper function to load adj matrices and do graph analyses.

%% load dataset

%loop through parcellations

n=1;
for Parcellation = 0  %:22
    Full_fn = strcat('/home/despoB/kaihwang/Rest/AdjMatrices/t',subjid,'_Full_WashU333_corrmat_corrmat'); %full matrix % num2str(Parcellation,'%03i')
    Right_fn = strcat('/home/despoB/kaihwang/Rest/AdjMatrices/t',subjid,'_Right_WashU333_corrmat'); %right hemi
    Left_fn = strcat('/home/despoB/kaihwang/Rest/AdjMatrices/t',subjid,'_Left_WashU333_corrmat'); %left hemi
    
    Adj.Matrix_Full{n} = load(Full_fn);
    Adj.Matrix_Right{n} = load(Right_fn);
    Adj.Matrix_Left{n} = load(Left_fn);
    
    n=n+1;
end

%% do graph

for n = 1:length(Adj.Matrix_Full)
   M = Adj.Matrix_Full{n};
   
   i = 1;
   for T = 0.05:0.005:0.15; %density threshold
      
       [Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'));
       CC=clustering_coef_bu(weight_conversion(threshold_proportional(M,T),'binarize'));
       Output = cal_modularity_connectivity(threshold_proportional(M,T), Ci);
       
       Graph.Full_Q{n}(i) = Q;
       Graph.Full_E{n}(i) = E;
       Graph.Full_Ci{n}(i,:) = Ci;
       Graph.Full_CC{n}(i,:) = CC;
       Graph.Within_Module_Degree{n}(i,:) = Output.Within_Degree;
       Graph.Out_Module_Degree{n}(i,:) = Output.Out_Degree;
       Graph.Within_Module_Weight{n}(i,:) = Output.Within_Weight;
       Graph.Out_Module_Weight{n}(i,:) = Output.Out_Weight;
       

       i = i+1;       
   end
end

for n = 1:length(Adj.Matrix_Full)
   M = Adj.Matrix_Right{n};
   
   i = 1;
   for T =  0.05:0.005:0.15;
      
       [Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'));
       CC=clustering_coef_bu(weight_conversion(threshold_proportional(M,T),'binarize'));
       Output = cal_modularity_connectivity(threshold_proportional(M,T), Ci);
       
       Graph.Right_Q{n}(i) = Q;
       Graph.Right_E{n}(i) = E;
       Graph.Right_Ci{n}(i,:) = Ci;
       Graph.Right_CC{n}(i,:) = CC;
       Graph.Right_Within_Module_Degree{n}(i,:) = Output.Within_Degree;
       Graph.Right_Out_Module_Degree{n}(i,:) = Output.Out_Degree;
       Graph.Right_Within_Module_Weight{n}(i,:) = Output.Within_Weight;
       Graph.Right_Out_Module_Weight{n}(i,:) = Output.Out_Weight;
       
       i = i+1;       
   end
end

for n = 1:length(Adj.Matrix_Full)
   M = Adj.Matrix_Left{n};
   
   i = 1;
   for T = 0.05:0.005:0.15;
      
       [Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'));
       CC=clustering_coef_bu(weight_conversion(threshold_proportional(M,T),'binarize'));
       Output = cal_modularity_connectivity(threshold_proportional(M,T), Ci);
       
       Graph.Left_Q{n}(i) = Q;
       Graph.Left_E{n}(i) = E;
       Graph.Left_Ci{n}(i,:) = Ci;
       Graph.Left_CC{n}(i,:) = CC;
       Graph.Left_Within_Module_Degree{n}(i,:) = Output.Within_Degree;
       Graph.Left_Out_Module_Degree{n}(i,:) = Output.Out_Degree;
       Graph.Left_Within_Module_Weight{n}(i,:) = Output.Within_Weight;
       Graph.Left_Out_Module_Weight{n}(i,:) = Output.Out_Weight;
       
       i = i+1;       
   end
end
