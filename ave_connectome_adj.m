% script to average connectome thalamo-cortical matrices.

Subjects = load('~/Rest/connectome/list_of_complete_subjects')';


M=zeros(1,3836,3836);
tempM=zeros(1,3836,3836);
for sub = Subjects;
	fn = strcat('g_FIX_',num2str(sub),'.mat');
	load(fn);
	tempM(1,:,:)=squeeze(Adj.Matrix_Full{1});
	M=tempM+M;
	clear Adj
	clear Graph
end

AveAdjM = squeeze(M)./length(Subjects);