
%% plot modularity
t=2;
close all
figure
H1=shadedErrorBar(T,squeeze(Modularity_Control(t,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H2=plot(T,squeeze(Modularity_tha(t,1,:)),'linewidth',3,'color','b');
H3=plot(T,squeeze(Modularity_tha(t,2,:)),'linewidth',3,'color','r');
H4=plot(T,squeeze(Modularity_tha(t,3,:)),'linewidth',3,'color','g');
H5=plot(T,squeeze(Modularity_tha(t,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
ylim([0.25 0.65])
hl=legend([H1.mainLine,H2, H3, H4, H5],'Controls ','Patient 128','Patient 162', 'Patient 163', 'Patient 168','Location','Northeast' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Modularity','FontSize',24)
title('Whole Brain Modularity','FontSize',24)
set(gcf, 'Color', 'white');
%export_fig Modularity.png, 

figure
H1=shadedErrorBar(T,squeeze(Modularity_Control_L(t,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H2=shadedErrorBar(T,squeeze(Modularity_Control_R(t,:,:)),{@mean, @std},{'--','LineWidth',6,'Color',rgb('grey')},1);
H3=plot(T,squeeze(Modularity_tha_L(t,1,:)),'linewidth',3,'color','b');
H4=plot(T,squeeze(Modularity_tha_R(t,2,:)),'linewidth',3,'color','r');
H5=plot(T,squeeze(Modularity_tha_L(t,3,:)),'linewidth',3,'color','g');
H6=plot(T,squeeze(Modularity_tha_R(t,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
ylim([0.25 0.65])
hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6],'Controls Left','Controls Right','Patient 128','Patient 162', 'Patient 163', 'Patient 168','Location','Northeast' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Modularity','FontSize',24)
title('Lesioned Hemisphere Modularity','FontSize',24)
set(gcf, 'Color', 'white');
%export_fig Modularity_lesioned_hemisphere.png

figure
H1=shadedErrorBar(T,squeeze(Modularity_Control_L(t,:,:)-Modularity_Control_R(2,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H3=plot(T,squeeze(Modularity_tha_L(t,1,:)-Modularity_tha_R(t,1,:)),'linewidth',3,'color','b');
H4=plot(T,squeeze(Modularity_tha_R(t,2,:)-Modularity_tha_L(t,2,:)),'linewidth',3,'color','r');
H5=plot(T,squeeze(Modularity_tha_L(t,3,:)-Modularity_tha_R(t,3,:)),'linewidth',3,'color','g');
H6=plot(T,squeeze(Modularity_tha_R(t,4,:)-Modularity_tha_L(t,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
%ylim([0.25 0.65])
hl=legend([H1.mainLine,H3, H4, H5, H6],'Controls L-R','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact','Location','best' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Diff in Modularity','FontSize',24)
title('Hemispheric Diff','FontSize',24)
set(gcf, 'Color', 'white');
%export_fig Modularity_hemDiff.png

%% plot efficiency
t=3;
close all
figure
H1=shadedErrorBar(T,squeeze(Efficiency_Control(t,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H2=plot(T,squeeze(Efficiency_tha(t,1,:)),'linewidth',3,'color','b');
H3=plot(T,squeeze(Efficiency_tha(t,2,:)),'linewidth',3,'color','r');
H4=plot(T,squeeze(Efficiency_tha(t,3,:)),'linewidth',3,'color','g');
H5=plot(T,squeeze(Efficiency_tha(t,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
ylim([0.25 0.65])
hl=legend([H1.mainLine,H2, H3, H4, H5],'Controls ','Patient 128','Patient 162', 'Patient 163', 'Patient 168','Location','Southeast' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Efficiency','FontSize',24)
title('Whole Brain Efficiency','FontSize',24)
set(gcf, 'Color', 'white');
%export_fig Efficiency.png; 

figure
H1=shadedErrorBar(T,squeeze(Efficiency_Control_L(t,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H2=shadedErrorBar(T,squeeze(Efficiency_Control_R(t,:,:)),{@mean, @std},{'--','LineWidth',6,'Color',rgb('grey')},1);
H3=plot(T,squeeze(Efficiency_tha_L(t,1,:)),'linewidth',3,'color','b');
H4=plot(T,squeeze(Efficiency_tha_R(t,2,:)),'linewidth',3,'color','r');
H5=plot(T,squeeze(Efficiency_tha_L(t,3,:)),'linewidth',3,'color','g');
H6=plot(T,squeeze(Efficiency_tha_R(t,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
ylim([0.25 0.65])
hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6],'Controls Left','Controls Right','Patient 128','Patient 162', 'Patient 163', 'Patient 168','Location','best' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Efficiency','FontSize',24)
title('Lesioned Hemisphere Efficiency','FontSize',24)
set(gcf, 'Color', 'white');
%export_fig Efficiency_lesioned_hemisphere.png

figure
H1=shadedErrorBar(T,squeeze(Efficiency_Control_L(t,:,:)-Efficiency_Control_R(2,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H3=plot(T,squeeze(Efficiency_tha_L(t,1,:)-Efficiency_tha_R(t,1,:)),'linewidth',3,'color','b');
H4=plot(T,squeeze(Efficiency_tha_R(t,2,:)-Efficiency_tha_L(t,2,:)),'linewidth',3,'color','r');
H5=plot(T,squeeze(Efficiency_tha_L(t,3,:)-Efficiency_tha_R(t,3,:)),'linewidth',3,'color','g');
H6=plot(T,squeeze(Efficiency_tha_R(t,4,:)-Efficiency_tha_L(t,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
%ylim([0.25 0.65])
hl=legend([H1.mainLine,H3, H4, H5, H6],'Controls L-R','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact','Location','best' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Diff in Efficiency','FontSize',24)
title('Hemispheric Diff','FontSize',24)
set(gcf, 'Color', 'white');
%export_fig Efficiency_hemDiff.png