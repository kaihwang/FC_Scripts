function  [Output] = cal_modularity_connectivity(W,Ci)
% function to calcuate within and betwee community connectivity.



n=length(W);                        %number of vertices
Within_Degree = zeros(n,1);
Out_Degree = zeros(n,1);
Within_Weight = zeros(n,1);
Out_Weight = zeros(n,1);
bW = weight_conversion(W, 'binarize'); %binarize for degree
for i=1:max(Ci)
    Within_Degree(Ci==i) = nansum(bW(Ci==i,Ci==i),2);
    Out_Degree(Ci==i) = nansum(bW(Ci==i,Ci~=i),2);
    Within_Weight(Ci==i) = nanmean(W(Ci==i,Ci==i),2);
    Out_Weight(Ci==i) = nanmean(W(Ci==i,Ci~=i),2);
end

% Output
Output.Within_Degree = Within_Degree;
Output.Out_Degree = Out_Degree;
Output.Within_Weight = Within_Weight;
Output.Out_Weight = Out_Weight;
