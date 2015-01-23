% script to average connectome thalamo-cortical matrices.

Subjects = load('~/Rest/connectome/list_of_complete_subjects')';

n=1;
M=zeros(length(Subjects),2364,2364);
for sub = Subjects;
	fn = strcat('g_',num2str(sub),'.mat');
	load(fn)
	M(n,:,:)=squeeze(Adj.Matrix_Full{1});
	n=n+1;
	clear Adj
	clear Graph
end

