close all
figure
H1=shadedErrorBar(T,squeeze(Modularity_Control(2,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H2=plot(T,squeeze(Modularity_tha(2,1,:)),'linewidth',3,'color','b');
H3=plot(T,squeeze(Modularity_tha(2,2,:)),'linewidth',3,'color','r');
H4=plot(T,squeeze(Modularity_tha(2,3,:)),'linewidth',3,'color','g');
H5=plot(T,squeeze(Modularity_tha(2,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
ylim([0.25 0.65])
hl=legend([H1.mainLine,H2, H3, H4, H5],'Controls ','Patient 128','Patient 162', 'Patient 163', 'Patient 168','Location','Northeast' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Modularity','FontSize',24)
title('Whole Brain Modularity','FontSize',24)
set(gcf, 'Color', 'white');
export_fig Modularity.png, 

figure
H1=shadedErrorBar(T,squeeze(Modularity_Control_L(2,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H2=shadedErrorBar(T,squeeze(Modularity_Control_R(2,:,:)),{@mean, @std},{'--','LineWidth',6,'Color',rgb('grey')},1);
H3=plot(T,squeeze(Modularity_tha_L(2,1,:)),'linewidth',3,'color','b');
H4=plot(T,squeeze(Modularity_tha_R(2,2,:)),'linewidth',3,'color','r');
H5=plot(T,squeeze(Modularity_tha_L(2,3,:)),'linewidth',3,'color','g');
H6=plot(T,squeeze(Modularity_tha_R(2,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
ylim([0.25 0.65])
hl=legend([H1.mainLine,H2.mainLine,H3, H4, H5, H6],'Controls Left','Controls Right','Patient 128','Patient 162', 'Patient 163', 'Patient 168','Location','Northeast' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Modularity','FontSize',24)
title('Lesioned Hemisphere Modularity','FontSize',24)
set(gcf, 'Color', 'white');
export_fig Modularity_lesioned_hemisphere.png

figure
H1=shadedErrorBar(T,squeeze(Modularity_Control_L(2,:,:)-Modularity_Control_R(2,:,:)),{@mean, @std},{'-','LineWidth',6,'Color',rgb('grey')},1);
hold on;
H3=plot(T,squeeze(Modularity_tha_L(2,1,:)-Modularity_tha_R(2,1,:)),'linewidth',3,'color','b');
H4=plot(T,squeeze(Modularity_tha_R(2,2,:)-Modularity_tha_L(2,2,:)),'linewidth',3,'color','r');
H5=plot(T,squeeze(Modularity_tha_L(2,3,:)-Modularity_tha_R(2,3,:)),'linewidth',3,'color','g');
H6=plot(T,squeeze(Modularity_tha_R(2,4,:)-Modularity_tha_L(2,4,:)),'linewidth',3,'color','y');
xlim([0.05 0.16])
%ylim([0.25 0.65])
hl=legend([H1.mainLine,H3, H4, H5, H6],'Controls L-R','Patient 128 Lesioned - Intact','Patient 162 Lesioned - Intact', 'Patient 163 Lesioned - Intact', 'Patient 168 Lesioned - Intact','Location','best' );
set(gca,'FontSize',16,'box','off','XGrid','off','YGrid','off','linewidth',10)
set(hl,'FontSize', 12, 'Box','off');
xlabel('Cost','FontSize',24)
ylabel('Diff in Modularity','FontSize',24)
title('Hemispheric Diff','FontSize',24)
set(gcf, 'Color', 'white');
export_fig Modularity_hemDiff.png