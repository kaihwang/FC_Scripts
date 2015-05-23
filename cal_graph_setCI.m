function  [Adj, Graph] = cal_graph_setCI(subjid)
% wrapper function to load adj matrices and do graph analyses.

%% load dataset
load /home/despoB/kaihwang/Rest/ROIs/WashU333_Communities.mat
WashU297ROI_CI = load('/home/despoB/kaihwang/bin/FuncParcel/Data/MGH_CI');
%loop through parcellations

n=1;
for Parcellation = 1  %:22
    Full_fn = strcat('/home/despoB/kaihwang/Rest/AdjMatrices/t',subjid,'_Full_WashU333_corrmat'); %full matrix % num2str(Parcellation,'%03i')
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
   for T = 0.01:0.005:0.25; %density threshold
      
       Q = 0; 
       Ci=[];
       for iter = 1:100
          [Ci_iter, q_iter] = community_louvain(weight_conversion(threshold_proportional(M,T),'binarize'),1);
          
          if q_iter > Q;
            Q = q_iter;
            Ci = Ci_iter;
          end
          
       end
       %[Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize')); %convert to binary adj matrices
       E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'));
       loc_E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'), 1);
       CC=clustering_coef_bu(weight_conversion(threshold_proportional(M,T),'binarize'));
       Output = cal_modularity_connectivity(threshold_proportional(M,T),  WashU297ROI_CI); %threshould by desntiy but keep weights
       
       %save graph outputs
       Graph.Degree{n}(i,:) = degrees_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       Graph.Weight{n}(i,:) = strengths_und(threshold_proportional(M,T));
       [Graph.Pos_Weight{n}(i,:), Graph.Neg_Weight{n}(i,:)] = strengths_und_sign(threshold_proportional(M,T));
       Graph.P{n}(i,:) = participation_coef(weight_conversion(threshold_proportional(M,T),'binarize'), WashU297ROI_CI);
       Graph.Full_Q{n}(i) = Q;
       Graph.Full_E{n}(i) = E;
       Graph.Full_locE{n}(i,:) = loc_E;
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
   M = Adj.Matrix_Full{n};
   M = M(146:297, 146:297);
   i = 1;
   for T =  0.01:0.005:0.25;
       
       Q = 0; 
       Ci=[];
       for iter = 1:100
          [Ci_iter, q_iter] = community_louvain(weight_conversion(threshold_proportional(M,T),'binarize'),1);
          
          if q_iter > Q;
            Q = q_iter;
            Ci = Ci_iter;
          end
          
       end 
       %[Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'));
       loc_E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'), 1);
       CC=clustering_coef_bu(weight_conversion(threshold_proportional(M,T),'binarize'));
       Output = cal_modularity_connectivity(threshold_proportional(M,T),  WashU297ROI_CI(146:297));
       
       Graph.Right_Weight{n}(i,:) = strengths_und(threshold_proportional(M,T));
       Graph.Right_Degree{n}(i,:) = degrees_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       [Graph.Right_Pos_Weight{n}(i,:), Graph.Right_Neg_Weight{n}(i,:)] = strengths_und_sign(threshold_proportional(M,T));
       Graph.Right_P{n}(i,:) = participation_coef(weight_conversion(threshold_proportional(M,T),'binarize'),WashU297ROI_CI(146:297));
       Graph.Right_Q{n}(i) = Q;
       Graph.Right_E{n}(i) = E;
       Graph.Right_locE{n}(i,:) = loc_E;
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
   M = Adj.Matrix_Full{n};
   M = M(1:145, 1:145);
   i = 1;
   for T = 0.01:0.005:0.25;
       
       Q = 0; 
       Ci=[];
       for iter = 1:100
          [Ci_iter, q_iter] = community_louvain(weight_conversion(threshold_proportional(M,T),'binarize'),1);
          
          if q_iter > Q;
            Q = q_iter;
            Ci = Ci_iter;
          end
          
       end
       %[Ci,Q] = modularity_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'));
       loc_E = efficiency_bin(weight_conversion(threshold_proportional(M,T),'binarize'), 1);
       CC=clustering_coef_bu(weight_conversion(threshold_proportional(M,T),'binarize'));
       Output = cal_modularity_connectivity(threshold_proportional(M,T), WashU297ROI_CI(1:145));
       
       Graph.Left_Weight{n}(i,:) = strengths_und(threshold_proportional(M,T));
       Graph.Left_Degree{n}(i,:) = degrees_und(weight_conversion(threshold_proportional(M,T),'binarize'));
       [Graph.Left_Pos_Weight{n}(i,:), Graph.Left_Neg_Weight{n}(i,:)] = strengths_und_sign(threshold_proportional(M,T));
       Graph.Left_P{n}(i,:) = participation_coef(weight_conversion(threshold_proportional(M,T),'binarize'),WashU297ROI_CI(1:145));
       Graph.Left_Q{n}(i) = Q;
       Graph.Left_E{n}(i) = E;
       Graph.Left_locE{n}(i,:) = loc_E;
       Graph.Left_Ci{n}(i,:) = Ci;
       Graph.Left_CC{n}(i,:) = CC;
       Graph.Left_Within_Module_Degree{n}(i,:) = Output.Within_Degree;
       Graph.Left_Out_Module_Degree{n}(i,:) = Output.Out_Degree;
       Graph.Left_Within_Module_Weight{n}(i,:) = Output.Within_Weight;
       Graph.Left_Out_Module_Weight{n}(i,:) = Output.Out_Weight;
       
       i = i+1;       
   end
end
