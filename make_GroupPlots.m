% plotting group averages
%% load datas


%load connectome

Control_Subj = load('/home/despoB/connectome-thalamus/connectome/list_of_complete_subjects');
Control_Subj = Control_Subj'
%Subjects
%Control_Subj = [114 116 117 118 119 201 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220];
Tha_Subj = [128 162 163 168 176];
BG_Subj = [116 117 120 121 122 138 143 153];


%Partitins
Partitions = 1%23%1:23;

%load previously obtaiend modularity parition
%load /home/despo/kaihwang/Rest/Graph/Control_Communities.mat;

%threshold
T=0.05:0.005:0.15;

%load controls
s=1;
for sub = Control_Subj
    fn = strcat('/home/despoB/kaihwang/Rest/Graph/g_',num2str(sub),'.mat');
    load (fn);
    
    for p = Partitions %1: length(Graph.Full_Q)
        Modularity_Control(p,s,:) = Graph.Full_Q{p};
        Modularity_Control_R(p,s,:) = Graph.Right_Q{p};
        Modularity_Control_L(p,s,:) = Graph.Left_Q{p};
        
        Efficiency_Control(p,s,:) = Graph.Full_E{p};
        Efficiency_Control_R(p,s,:) = Graph.Right_E{p};
        Efficiency_Control_L(p,s,:) = Graph.Left_E{p};
        
        %Adj_Control{p}(s,:,:) = Adj.Matrix_Full{p};
        %Adj_Control_R{p}(s,:,:) = Adj.Matrix_Right{p};
        %Adj_Control_L{p}(s,:,:) = Adj.Matrix_Left{p};
        
        Within_Module_Degree_Control(p,s,:) = nanmean(Graph.Within_Module_Degree{p},2);
        Out_Module_Degree_Control(p,s,:) = nanmean(Graph.Out_Module_Degree{p},2);
        Within_Module_Weight_Control(p,s,:) = nanmean(Graph.Within_Module_Weight{p},2);
        Out_Module_Weight_Control(p,s,:) = nanmean(Graph.Out_Module_Weight{p},2);
        
        Within_Module_Degree_Control_L(p,s,:) = nanmean(Graph.Left_Within_Module_Degree{p},2);
        Out_Module_Degree_Control_L(p,s,:) = nanmean(Graph.Left_Out_Module_Degree{p},2);
        Within_Module_Weight_Control_L(p,s,:) = nanmean(Graph.Left_Within_Module_Weight{p},2);
        Out_Module_Weight_Control_L(p,s,:) = nanmean(Graph.Left_Out_Module_Weight{p},2);
        
        Within_Module_Degree_Control_R(p,s,:) = nanmean(Graph.Right_Within_Module_Degree{p},2);
        Out_Module_Degree_Control_R(p,s,:) = nanmean(Graph.Right_Out_Module_Degree{p},2);
        Within_Module_Weight_Control_R(p,s,:) = nanmean(Graph.Right_Within_Module_Weight{p},2);
        Out_Module_Weight_Control_R(p,s,:) = nanmean(Graph.Right_Out_Module_Weight{p},2);
        
        
        CC_Control(p,s,:) =nanmean(Graph.Full_CC{p},2);
        CC_Control_L(p,s,:) = nanmean(Graph.Left_CC{p},2);
        CC_Control_R(p,s,:) = nanmean(Graph.Right_CC{p},2);
        
    end
    
    s=s+1;
end

% load tha patients
s=1;
for sub = Tha_Subj
    fn = strcat('/home/despoB/kaihwang/Rest/Graph/g_',num2str(sub),'.mat');
    load (fn);
    for p = Partitions %1: length(Graph.Full_Q)
        Modularity_tha(p,s,:) = Graph.Full_Q{p};
        Modularity_tha_R(p,s,:) = Graph.Right_Q{p};
        Modularity_tha_L(p,s,:) = Graph.Left_Q{p};
        
        Efficiency_tha(p,s,:) = Graph.Full_E{p};
        Efficiency_tha_R(p,s,:) = Graph.Right_E{p};
        Efficiency_tha_L(p,s,:) = Graph.Left_E{p};
        
        %Adj_Tha{p}(s,:,:) = Adj.Matrix_Full{p};
        %Adj_Tha_R{p}(s,:,:) = Adj.Matrix_Right{p};
        %Adj_Tha_L{p}(s,:,:) = Adj.Matrix_Left{p};
        
        Within_Module_Degree_tha(p,s,:) = nanmean(Graph.Within_Module_Degree{p},2);
        Out_Module_Degree_tha(p,s,:) = nanmean(Graph.Out_Module_Degree{p},2);
        Within_Module_Weight_tha(p,s,:) = nanmean(Graph.Within_Module_Weight{p},2);
        Out_Module_Weight_tha(p,s,:) = nanmean(Graph.Out_Module_Weight{p},2);
        
        Within_Module_Degree_tha_L(p,s,:) = nanmean(Graph.Left_Within_Module_Degree{p},2);
        Out_Module_Degree_tha_L(p,s,:) = nanmean(Graph.Left_Out_Module_Degree{p},2);
        Within_Module_Weight_tha_L(p,s,:) = nanmean(Graph.Left_Within_Module_Weight{p},2);
        Out_Module_Weight_tha_L(p,s,:) = nanmean(Graph.Left_Out_Module_Weight{p},2);
        
        Within_Module_Degree_tha_R(p,s,:) = nanmean(Graph.Right_Within_Module_Degree{p},2);
        Out_Module_Degree_tha_R(p,s,:) = nanmean(Graph.Right_Out_Module_Degree{p},2);
        Within_Module_Weight_tha_R(p,s,:) = nanmean(Graph.Right_Within_Module_Weight{p},2);
        Out_Module_Weight_tha_R(p,s,:) = nanmean(Graph.Right_Out_Module_Weight{p},2);
        
        
        CC_tha(p,s,:) =nanmean(Graph.Full_CC{p},2);
        CC_tha_L(p,s,:) = nanmean(Graph.Left_CC{p},2);
        CC_tha_R(p,s,:) = nanmean(Graph.Right_CC{p},2);
    end
    
    s=s+1;
end

% load BG patients
s=1;
for sub = BG_Subj
    fn = strcat('/home/despoB/kaihwang/Rest/Graph/g_b',num2str(sub),'.mat');
    load (fn);
    for p = Partitions %1: length(Graph.Full_Q)
        Modularity_BG(p,s,:) = Graph.Full_Q{p};
        Modularity_BG_R(p,s,:) = Graph.Right_Q{p};
        Modularity_BG_L(p,s,:) = Graph.Left_Q{p};
        
        Efficiency_BG(p,s,:) = Graph.Full_E{p};
        Efficiency_BG_R(p,s,:) = Graph.Right_E{p};
        Efficiency_BG_L(p,s,:) = Graph.Left_E{p};
        
        %Adj_Tha{p}(s,:,:) = Adj.Matrix_Full{p};
        %Adj_Tha_R{p}(s,:,:) = Adj.Matrix_Right{p};
        %Adj_Tha_L{p}(s,:,:) = Adj.Matrix_Left{p};
        
        Within_Module_Degree_BG(p,s,:) = nanmean(Graph.Within_Module_Degree{p},2);
        Out_Module_Degree_BG(p,s,:) = nanmean(Graph.Out_Module_Degree{p},2);
        Within_Module_Weight_BG(p,s,:) = nanmean(Graph.Within_Module_Weight{p},2);
        Out_Module_Weight_BG(p,s,:) = nanmean(Graph.Out_Module_Weight{p},2);
        
        Within_Module_Degree_BG_L(p,s,:) = nanmean(Graph.Left_Within_Module_Degree{p},2);
        Out_Module_Degree_BG_L(p,s,:) = nanmean(Graph.Left_Out_Module_Degree{p},2);
        Within_Module_Weight_BG_L(p,s,:) = nanmean(Graph.Left_Within_Module_Weight{p},2);
        Out_Module_Weight_BG_L(p,s,:) = nanmean(Graph.Left_Out_Module_Weight{p},2);
        
        Within_Module_Degree_BG_R(p,s,:) = nanmean(Graph.Right_Within_Module_Degree{p},2);
        Out_Module_Degree_BG_R(p,s,:) = nanmean(Graph.Right_Out_Module_Degree{p},2);
        Within_Module_Weight_BG_R(p,s,:) = nanmean(Graph.Right_Within_Module_Weight{p},2);
        Out_Module_Weight_BG_R(p,s,:) = nanmean(Graph.Right_Out_Module_Weight{p},2);
        
        
        CC_BG(p,s,:) =nanmean(Graph.Full_CC{p},2);
        CC_BG_L(p,s,:) = nanmean(Graph.Left_CC{p},2);
        CC_BG_R(p,s,:) = nanmean(Graph.Right_CC{p},2);
    end
    
    s=s+1;
end

clear Graph Adj s sub p t i



%% plot modularity
set(0, 'DefaulttextInterpreter', 'none')

close all
T=0.05:0.005:0.15;
for t=Partitions;
    
    figure
    H1=shadedErrorBar(T,squeeze(Modularity_Control(t,:,:)),{@mean, 1.5*@std},{'-','LineWidth',3,'Color',rgb('gray')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Modularity_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    H3=shadedErrorBar(T,squeeze(Modularity_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('orange')},1);
    hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Modularity','FontSize',14)
    title('Whole Brain Modularity','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('Modularity_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    
    figure
    H1=shadedErrorBar(T,squeeze(Modularity_Control_L(t,:,:)),{@mean, @std},{'-','LineWidth',2,'Color',rgb('gray')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Modularity_Control_R(t,:,:)),{@mean, @std},{'--','LineWidth',2,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(Modularity_tha_L(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Modularity_tha_R(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Modularity_tha_L(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Modularity_tha_R(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Modularity_tha_R(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128','Patient 162', 'Patient 163', 'Patient 168', 'Patient 176', 'Location','Northeast' );
    set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',16)
    ylabel('Modularity','FontSize',16)
    title('Lesioned Hemisphere Modularity','FontSize',24)
    set(gcf, 'Color', 'white');
    fn = strcat('Modularity_lesioned_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig Modularity_lesioned_hemisphere_350.png -opengl
    
    figure
    H1=shadedErrorBar(T,squeeze(Modularity_Control_L(t,:,:)),{@mean, @ste},{'-','LineWidth',2,'Color',rgb('gray')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Modularity_Control_R(t,:,:)),{@mean, @ste},{'--','LineWidth',2,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(Modularity_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Modularity_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Modularity_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Modularity_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Modularity_tha_L(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128','Patient 162', 'Patient 163', 'Patient 168', 'Patient 176', 'Location','Northeast' );
    set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',16)
    ylabel('Modularity','FontSize',16)
    title('Intact Hemisphere Modularity','FontSize',24)
    set(gcf, 'Color', 'white');
    fn = strcat('Modularity_Intact_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    
    figure
    H1=shadedErrorBar(T,squeeze(Modularity_Control_R(t,:,:)-Modularity_Control_L(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('gray')},1);
    hold on;
    H3=plot(T,squeeze(Modularity_tha_L(t,1,:)-Modularity_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Modularity_tha_R(t,2,:)-Modularity_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Modularity_tha_L(t,3,:)-Modularity_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Modularity_tha_R(t,4,:)-Modularity_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Modularity_tha_R(t,5,:)-Modularity_tha_L(t,5,:)),'linewidth',3,'color','m');
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H3, H4, H5, H6, H7],'Controls R-L','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact', 'Patient 176 Lesioned - Intact','Location','best' );
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Diff in Modularity','FontSize',14)
    title('Hemispheric Diff in Modularity','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('Modularity_hemDiff_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig Modularity_hemDiff_350.png -opengl
end

%% plot between module connectivity
set(0, 'DefaulttextInterpreter', 'none')
%close all
T=0.05:0.005:0.15;
for t=Partitions;
    
    figure
    H1=shadedErrorBar(T,squeeze(Out_Module_Weight_Control(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('gray')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Out_Module_Weight_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    H3=shadedErrorBar(T,squeeze(Out_Module_Weight_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('orange')},1);
    xlim([0.05 0.16])
    hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    
    %ylim([0.25 0.65])
    set(gca,'FontSize',12,'Box','Off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Connectivity Weight','FontSize',14)
    title('Whole Brain Between Modules Connectivity Weight','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('InterModule_Weight_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    
    figure
    H1=shadedErrorBar(T,squeeze(Out_Module_Weight_Control_L(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('grey')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Out_Module_Weight_Control_R(t,:,:)),{@mean, @ste},{'--','LineWidth',3,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(Out_Module_Weight_tha_L(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Out_Module_Weight_tha_R(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Out_Module_Weight_tha_L(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Out_Module_Weight_tha_R(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Out_Module_Weight_tha_R(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128(L)','Patient 162(R)', 'Patient 163(L)', 'Patient 168(R)', 'Patient 176(R)', 'Location','best' );
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Connectivity Weight','FontSize',14)
    title('Between Modules Connectivity Weight fot the Lesioned Hemisphere','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('InterModule_Weight_lesioned_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig Out_Module_Weight_lesioned_hemisphere_350.png -opengl
    
    figure
    H1=shadedErrorBar(T,squeeze(Out_Module_Weight_Control_L(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('grey')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Out_Module_Weight_Control_R(t,:,:)),{@mean, @ste},{'--','LineWidth',3,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(Out_Module_Weight_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Out_Module_Weight_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Out_Module_Weight_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Out_Module_Weight_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Out_Module_Weight_tha_L(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128(L)','Patient 162(R)', 'Patient 163(L)', 'Patient 168(R)', 'Patient 176(R)', 'Location','best' );
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Connectivity Weight','FontSize',14)
    title('Between Modules Connectivity Weight fot the Intact Hemisphere','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('InterModule_Weight_Intact_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    
    figure
    H1=shadedErrorBar(T,squeeze(Out_Module_Weight_Control_R(t,:,:)-Out_Module_Weight_Control_L(t,:,:)),{@mean, @ste},{'-','LineWidth',6,'Color',rgb('grey')},1);
    hold on;
    H3=plot(T,squeeze(Out_Module_Weight_tha_L(t,1,:)-Out_Module_Weight_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Out_Module_Weight_tha_R(t,2,:)-Out_Module_Weight_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Out_Module_Weight_tha_L(t,3,:)-Out_Module_Weight_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Out_Module_Weight_tha_R(t,4,:)-Out_Module_Weight_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Out_Module_Weight_tha_R(t,5,:)-Out_Module_Weight_tha_L(t,5,:)),'linewidth',3,'color','m');
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H3, H4, H5, H6, H7],'Controls R-L','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact', 'Patient 176 Lesioned - Intact','Location','best');
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Diff in Connectivity','FontSize',14)
    title('Hemispheric Diff in Between Modules Connectivity Weight','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('Inter_Module_Weight_hemDiff_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig Out_Module_Weight_hemDiff_350.png -opengl
end


%% plot within module connectivity
set(0, 'DefaulttextInterpreter', 'none')
%close all
T=0.05:0.005:0.15;
for t=Partitions;
    
    figure
    H1=shadedErrorBar(T,squeeze(Within_Module_Weight_Control(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('gray')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Within_Module_Weight_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    H3=shadedErrorBar(T,squeeze(Within_Module_Weight_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('orange')},1);
    hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Connectivity Weight','FontSize',14)
    title('Whole Brain Within Module Connectivity Weight','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('WithinModule_Weight_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    
    figure
    H1=shadedErrorBar(T,squeeze(Within_Module_Weight_Control_L(t,:,:)),{@nanmean, @ste},{'-','LineWidth',3,'Color',rgb('grey')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Within_Module_Weight_Control_R(t,:,:)),{@nanmean, @ste},{'--','LineWidth',3,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(Within_Module_Weight_tha_L(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Within_Module_Weight_tha_R(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Within_Module_Weight_tha_L(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Within_Module_Weight_tha_R(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Within_Module_Weight_tha_R(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128(L)','Patient 162(R)', 'Patient 163(L)', 'Patient 168(R)', 'Patient 176(R)', 'Location','best' );
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Connectivity Weight','FontSize',14)
    title('Within Module Connectivity Weight fot the Lesioned Hemisphere','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('WithinModule_Weight_lesioned_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig Within_Module_Weight_lesioned_hemisphere_350.png -opengl
    
    figure
    H1=shadedErrorBar(T,squeeze(Within_Module_Weight_Control_L(t,:,:)),{@nanmean, @ste},{'-','LineWidth',3,'Color',rgb('grey')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(Within_Module_Weight_Control_R(t,:,:)),{@nanmean, @ste},{'--','LineWidth',3,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(Within_Module_Weight_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Within_Module_Weight_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Within_Module_Weight_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Within_Module_Weight_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Within_Module_Weight_tha_L(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128(L)','Patient 162(R)', 'Patient 163(L)', 'Patient 168(R)', 'Patient 176(R)', 'Location','best' );
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Connectivity Weight','FontSize',14)
    title('Within Module Connectivity Weight fot the Intact Hemisphere','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('WithinModule_Weight_Intact_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig Within_Module_Weight_lesioned_hemisphere_350.png -opengl
    
    figure
    H1=shadedErrorBar(T,squeeze(Within_Module_Weight_Control_R(t,:,:)-Within_Module_Weight_Control_L(t,:,:)),{@nanmean, @ste},{'-','LineWidth',6,'Color',rgb('grey')},1);
    hold on;
    H3=plot(T,squeeze(Within_Module_Weight_tha_L(t,1,:)-Within_Module_Weight_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(Within_Module_Weight_tha_R(t,2,:)-Within_Module_Weight_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(Within_Module_Weight_tha_L(t,3,:)-Within_Module_Weight_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(Within_Module_Weight_tha_R(t,4,:)-Within_Module_Weight_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(Within_Module_Weight_tha_R(t,5,:)-Within_Module_Weight_tha_L(t,5,:)),'linewidth',3,'color','m');
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H3, H4, H5, H6, H7],'Controls R-L','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact', 'Patient 176 Lesioned - Intact','Location','best');
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Diff in Connectivity','FontSize',14)
    title('Hemispheric Diff in Within Modules Connectivity Weight','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('Within_Module_Weight_hemDiff_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig Within_Module_Weight_hemDiff_350.png -opengl
end

%% plot CC
set(0, 'DefaulttextInterpreter', 'none')
%close all
T=0.05:0.005:0.15;

for t=Partitions;
    
    figure
    H1=shadedErrorBar(T,squeeze(CC_Control(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('gray')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(CC_tha(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('blue')},1);
    H3=shadedErrorBar(T,squeeze(CC_BG(t,:,:)),{@mean, @ste},{'-','LineWidth',3,'Color',rgb('orange')},1);
    hl=legend([H1.mainLine,H2.mainLine, H3.mainLine],'Controls ','Thalamic Patients','BG Patients', 'Location','Best' );
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Clustering Coef','FontSize',14)
    title('Whole Brain Clustering Coef','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('CC_Weight_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    
    figure
    H1=shadedErrorBar(T,squeeze(CC_Control_L(t,:,:)),{@nanmean, @ste},{'-','LineWidth',3,'Color',rgb('grey')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(CC_Control_R(t,:,:)),{@nanmean, @ste},{'--','LineWidth',3,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(CC_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(CC_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(CC_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(CC_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(CC_tha_L(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128(L)','Patient 162(R)', 'Patient 163(L)', 'Patient 168(R)', 'Patient 176(R)', 'Location','best' );
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Clustering Coef','FontSize',14)
    title('Clustering Coef fot the intact Hemisphere','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('CC_Weight_intact_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig CC_lesioned_hemisphere_350.png -opengl
    
    figure
    H1=shadedErrorBar(T,squeeze(CC_Control_L(t,:,:)),{@nanmean, @ste},{'-','LineWidth',3,'Color',rgb('grey')},1);
    hold on;
    H2=shadedErrorBar(T,squeeze(CC_Control_R(t,:,:)),{@nanmean, @ste},{'--','LineWidth',3,'Color',rgb('light grey')},1);
    H3=plot(T,squeeze(CC_tha_L(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(CC_tha_R(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(CC_tha_L(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(CC_tha_R(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(CC_tha_R(t,5,:)),'linewidth',3,'color','m');
    
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128(L)','Patient 162(R)', 'Patient 163(L)', 'Patient 168(R)', 'Patient 176(R)', 'Location','best' );
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Clustering Coef','FontSize',14)
    title('Clustering Coef fot the Lesioned Hemisphere','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('CC_Weight_lesioned_hemisphere_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig CC_lesioned_hemisphere_350.png -opengl
    
    figure
    H1=shadedErrorBar(T,squeeze(CC_Control_R(t,:,:)-CC_Control_L(t,:,:)),{@nanmean, @ste},{'-','LineWidth',6,'Color',rgb('grey')},1);
    hold on;
    H3=plot(T,squeeze(CC_tha_L(t,1,:)-CC_tha_R(t,1,:)),'linewidth',3,'color','b');
    H4=plot(T,squeeze(CC_tha_R(t,2,:)-CC_tha_L(t,2,:)),'linewidth',3,'color','r');
    H5=plot(T,squeeze(CC_tha_L(t,3,:)-CC_tha_R(t,3,:)),'linewidth',3,'color','g');
    H6=plot(T,squeeze(CC_tha_R(t,4,:)-CC_tha_L(t,4,:)),'linewidth',3,'color','y');
    H7=plot(T,squeeze(CC_tha_R(t,5,:)-CC_tha_L(t,5,:)),'linewidth',3,'color','m');
    xlim([0.05 0.16])
    %ylim([0.25 0.65])
    hl=legend([H1.mainLine,H3, H4, H5, H6, H7],'Controls R-L','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact', 'Patient 176 Lesioned - Intact','Location','best');
    set(gca,'FontSize',12,'box','off','XGrid','off','YGrid','off','linewidth',2)
    set(hl,'FontSize', 12, 'Box','off');
    xlabel('Cost','FontSize',14)
    ylabel('Diff in Clustering Coef','FontSize',14)
    title('Hemispheric Diff in Clustering Coef','FontSize',16)
    set(gcf, 'Color', 'white');
    fn = strcat('CC_hemDiff_',num2str(t),'.png');
    %export_fig(fn, '-opengl');
    %export_fig CC_hemDiff_350.png -opengl
end



%% plot efficiency
%close all
%T=0.05:0.005:0.15;
%
%for t=12
%    figure
%    H1=shadedErrorBar(T,squeeze(Efficiency_Control(t,:,:)),{@mean, @ste},{'-','LineWidth',6,'Color',rgb('grey')},1);
%    hold on;
%    H2=plot(T,squeeze(Efficiency_tha(t,1,:)),'linewidth',3,'color','b');
%    H3=plot(T,squeeze(Efficiency_tha(t,2,:)),'linewidth',3,'color','r');
%    H4=plot(T,squeeze(Efficiency_tha(t,3,:)),'linewidth',3,'color','g');
%    H5=plot(T,squeeze(Efficiency_tha(t,4,:)),'linewidth',3,'color','y');
%    H6=plot(T,squeeze(Efficiency_tha(t,5,:)),'linewidth',3,'color','m');
%    xlim([0.05 0.16])
%    %ylim([0.25 0.65])
%    hl=legend([H1.mainLine,H2, H3, H4, H5, H6],'Controls ','Patient 128','Patient 162', 'Patient 163', 'Patient 168', 'Patient 176','Location','SWithinheast' );
%    set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',2)
%    set(hl,'FontSize', 12, 'Box','off');
%
%    ylabel('Efficiency','FontSize',16)
%    xlabel(gca, 'Cost','FontSize',16)
%    title('Whole Brain Efficiency','FontSize',24)
%    set(gcf, 'Color', 'white');
%    export_fig Efficiency_350.png -opengl
%
%    figure
%    H1=shadedErrorBar(T,squeeze(Efficiency_Control_L(t,:,:)),{@mean, @ste},{'-','LineWidth',6,'Color',rgb('grey')},1);
%    hold on;
%    H2=shadedErrorBar(T,squeeze(Efficiency_Control_R(t,:,:)),{@mean, @ste},{'--','LineWidth',6,'Color',rgb('grey')},1);
%    H3=plot(T,squeeze(Efficiency_tha_L(t,1,:)),'linewidth',3,'color','b');
%    H4=plot(T,squeeze(Efficiency_tha_R(t,2,:)),'linewidth',3,'color','r');
%    H5=plot(T,squeeze(Efficiency_tha_L(t,3,:)),'linewidth',3,'color','g');
%    H6=plot(T,squeeze(Efficiency_tha_R(t,4,:)),'linewidth',3,'color','y');
%    H7=plot(T,squeeze(Efficiency_tha_R(t,5,:)),'linewidth',3,'color','m');
%    xlim([0.05 0.16])
%    %ylim([0.25 0.65])
%    hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6, H7],'Controls Left','Controls Right','Patient 128','Patient 162', 'Patient 163', 'Patient 168','Patient 176','Location','best' );
%    set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',2)
%    set(hl,'FontSize', 12, 'Box','off');
%    xlabel('Cost','FontSize',16)
%    ylabel('Efficiency','FontSize',16)
%    title('Lesioned Hemisphere Efficiency','FontSize',24)
%    set(gcf, 'Color', 'white');
%    export_fig Efficiency_lesioned_hemisphere_350.png -opengl
%
%    figure
%    H1=shadedErrorBar(T,squeeze(Efficiency_Control_R(t,:,:)-Efficiency_Control_L(t,:,:)),{@mean, @ste},{'-','LineWidth',6,'Color',rgb('grey')},1);
%    hold on;
%    H3=plot(T,squeeze(Efficiency_tha_R(t,1,:)-Efficiency_tha_L(t,1,:)),'linewidth',3,'color','b');
%    H4=plot(T,squeeze(Efficiency_tha_R(t,2,:)-Efficiency_tha_L(t,2,:)),'linewidth',3,'color','r');
%    H5=plot(T,squeeze(Efficiency_tha_L(t,3,:)-Efficiency_tha_R(t,3,:)),'linewidth',3,'color','g');
%    H6=plot(T,squeeze(Efficiency_tha_L(t,4,:)-Efficiency_tha_R(t,4,:)),'linewidth',3,'color','y');
%    H7=plot(T,squeeze(Efficiency_tha_R(t,5,:)-Efficiency_tha_L(t,5,:)),'linewidth',3,'color','m');
%    xlim([0.05 0.16])
%    %ylim([0.25 0.65])
%    hl=legend([H1.mainLine,H3, H4, H5, H6, H7],'Controls R-L','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact','Patient 176 Lesioned - Intact','Location','best' );
%    set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',2)
%    set(hl,'FontSize', 12, 'Box','off');
%    xlabel('Cost','FontSize',16)
%    ylabel('Diff in Efficiency','FontSize',16)
%    title('Hemispheric Diff in Efficiency','FontSize',24)
%    set(gcf, 'Color', 'white');
%    export_fig Efficiency_hemDiff_350.png -opengl
%end