% Script to load data.

%% Setup

Modularity_tha=[]; 
Modularity_BG=[];
Modularity_Control=[];
%ROI_num = 708;

Th_Sub = [128, 162, 163, 168];
BG_Sub = [116 117 120 121 122 138 143 153];
C_Sub = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220];
%M_th = zeros(ROI_num,ROI_num, length (Th_Sub));
%M_BG = zeros(ROI_num,ROI_num, length (BG_Sub));
%M_c = zeros(ROI_num,ROI_num, length (C_Sub));

%% load data
n=1;
for s = Th_Sub
   fn = strcat('Data/t',num2str(s),'_full_corrmat_500');
   M_th(:,:,n) = load(fn);
   fn = strcat('Data/t',num2str(s),'_right_corrmat_500');
   M_th_R(:,:,n) = load(fn);
   fn = strcat('Data/t',num2str(s),'_left_corrmat_500');
   M_th_L(:,:,n) = load(fn);
   n=n+1;
end

n=1;
for s = BG_Sub
   fn = strcat('Data/b',num2str(s),'_full_corrmat_500');
   M_BG(:,:,n) = load(fn);
   fn = strcat('Data/b',num2str(s),'_right_corrmat_500');
   M_BG_R(:,:,n) = load(fn);
   fn = strcat('Data/b',num2str(s),'_left_corrmat_500');
   M_BG_L(:,:,n) = load(fn);
   n=n+1; 
end

n=1;
for s = C_Sub
   fn = strcat('Data/c',num2str(s),'_full_corrmat_500');
   M_c(:,:,n) = load(fn);
   fn = strcat('Data/c',num2str(s),'_right_corrmat_500');
   M_c_R(:,:,n) = load(fn);
   fn = strcat('Data/c',num2str(s),'_left_corrmat_500');
   M_c_L(:,:,n) = load(fn);
   n=n+1; 
end

clear n fn

save Data/Data_500.mat

% %% Modularity
% n=1;
% for s = Th_Sub
%     
%    M = squeeze(M_th(:,:,n));
%    [~,Q] = modularity_und(weight_conversion(threshold_proportional(M,.1),'binarize')); 
%    Modularity_tha = [Modularity_tha, Q]; 
%    n=n+1;
% end
% 
% n=1;
% for s = BG_Sub
% 
%    M = squeeze(M_BG(:,:,n));
%    [~,Q] = modularity_und(weight_conversion(threshold_proportional(M,.1),'binarize')); 
%    Modularity_BG = [Modularity_BG, Q]; 
%    n=n+1; 
% end
% 
% n=1;
% for s = C_Sub
%    fn = strcat('Data/c',num2str(s),'_full_corrmat');
%    M_c(:,:,n) = load(fn);
%    M = squeeze(M_c(:,:,n));
%    [~,Q] = modularity_und(weight_conversion(threshold_proportional(M,.1),'binarize'));
%    Modularity_Control = [Modularity_Control, Q]; 
%    n=n+1; 
% end
% 
% %% clean up
% 
% clear M fn Q