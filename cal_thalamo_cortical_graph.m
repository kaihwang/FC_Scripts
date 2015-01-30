function  [Adj, Graph] = cal_thalamo_cortical_graph(subjid)
% wrapper function to load adj matrices and do graph analysis specfically designed for thalamocortical matrices. 

%% load dataset

%loop through parcellations

n=1;
for Parcellation = 1  %:22
    Full_fn = strcat('/home/despoB/kaihwang/Rest/AdjMatrices/t',subjid,'_FIX_thalamocortical_corrmat'); %full matrix % num2str(Parcellation,'%03i')
    %Right_fn = strcat('/home/despoB/kaihwang/Rest/AdjMatrices/t',subjid,'_Right_Craddock700_corrmat'); %right hemi
    %Left_fn = strcat('/home/despoB/kaihwang/Rest/AdjMatrices/t',subjid,'_Left_Craddock700_corrmat'); %left hemi
    
    Adj.Matrix_Full{n} = load(Full_fn);
    %Adj.Matrix_Right{n} = load(Right_fn);
    %Adj.Matrix_Left{n} = load(Left_fn);
    
    n=n+1;
end

%% do graph

for n = 1:length(Adj.Matrix_Full) % loop through parcellations.. although now just using 1.
   M = Adj.Matrix_Full{n};
   
   i = 1;
   for T = 0.1; %density threshold
      
       [Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize')); %convert to binary adj matrices
       %E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'));
       %CC=clustering_coef_bu(weight_conversion(threshold_proportional(M,T),'binarize'));
       Output = cal_modularity_connectivity(threshold_proportional(M,T), Ci); %threshould by desntiy but keep weights
       
       %save graph outputs
       Graph.Weight{n}(i,:) = strengths_und(threshold_proportional(M,T));
       [Graph.Pos_Weight{n}(i,:), Graph.Neg_Weight{n}(i,:)] = strengths_und_sign(threshold_proportional(M,T));
       Graph.P{n}(i,:) = participation_coef(weight_conversion(threshold_proportional(M,T),'binarize'),Ci);
       Graph.Full_Q{n}(i) = Q;
       %Graph.Full_E{n}(i) = E;
       Graph.Full_Ci{n}(i,:) = Ci;
       %Graph.Full_CC{n}(i,:) = CC;
       Graph.Within_Module_Degree{n}(i,:) = Output.Within_Degree;
       Graph.Out_Module_Degree{n}(i,:) = Output.Out_Degree;
       Graph.Within_Module_Weight{n}(i,:) = Output.Within_Weight;
       Graph.Out_Module_Weight{n}(i,:) = Output.Out_Weight;
       

       i = i+1;       
   end
end


