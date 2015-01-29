# script to plot graph data
setwd("~/Google Drive/Projects/Thalamus-Rest/")

# import libraries
library(ggplot2)
library(plyr)

# read global graph data
DATA = read.csv("/Volumes//neuro/GlobalGraphData.csv", header=TRUE);



# two color scheme to use. 
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
cPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
BlueScale<-c("#f7fbff",
             "#deebf7",
             "#c6dbef",
             "#9ecae1",
             "#6baed6",
             "#4292c6",
             "#2171b5",
             "#084594")
WarmScale<-c("#ffffcc",
  "#ffeda0",
  "#fed976",
  "#feb24c",
  "#fd8d3c",
  "#fc4e2a",
  "#e31a1c",
  "#b10026")



# calculate summary statistics of the Modularity data
summaryDATA <- ddply(DATA, c('Group', 'Density'), summarise,
                             N = sum(!is.na(Modularity)),
                             mean = mean(Modularity, na.rm=TRUE),
                             sd = sd(Modularity, na.rm=TRUE),
                             se = sd/ sqrt(N),
                             upperSE = mean(Modularity, na.rm=TRUE) + se, #*clearsd(Modularity, na.rm=TRUE),
                             lowerSE = mean(Modularity, na.rm=TRUE) - se,
                             upperCI = mean(Modularity, na.rm=TRUE) + 1.5*sd(Modularity, na.rm=TRUE),
                             lowerCI = mean(Modularity, na.rm=TRUE) - 1.5*sd(Modularity, na.rm=TRUE))
              

# subsetting by dropping connectome subjects



# plot group Modularity data
fig_group <- ggplot(data=summaryDATA, aes(x=Density, y=mean))+ theme_classic(base_size = 24) + scale_colour_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_group <- fig_group + geom_line(aes(color=Group), size = 2)
fig_group <- fig_group + geom_ribbon(data = summaryDATA, aes(fill=Group, ymin=upperSE, ymax=lowerSE, x=Density ), alpha = 0.35)+ scale_fill_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_group <- fig_group + labs(y = "Modularity")
fig_group
ggsave(filename = "GroupModularity.pdf", plot = fig_group, width=8, height=8) 


# plot indiv patient modulairty against young controls
ControlDATA <- subset(summaryDATA, Group=='Young_Controls')
ComparisonDATA <- subset(summaryDATA, Group=='Young_Controls' | Group =='Striatal_Patients')
THData <- subset(DATA, Group =='Thalamic_Patients')
BGData <- subset(summaryDATA, Group =='Striatal_Patients')

fig_patient <- ggplot(data=ControlDATA , aes(x=Density, y=mean)) + theme_classic(base_size = 24) 
fig_patient <- fig_patient + geom_line(data=ComparisonDATA , aes(x=Density, y=mean,  color=Group), size = 2, inherit.aes=FALSE) + scale_colour_manual(values=c(BlueScale[2:6],"Yellow","#888888"))
fig_patient <- fig_patient + geom_ribbon(data = ControlDATA, aes( ymin=upperCI, ymax=lowerCI, x=Density, fill='Control CI (1.5 SD)' ), alpha = 0.15, inherit.aes=FALSE) + scale_fill_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_patient <- fig_patient + geom_line(data=THData, aes(x=Density, y=Modularity, color=Subject ), size = 2)  
fig_patient <- fig_patient + labs(y = "Modularity") + labs(Color='') + labs(fill='') 
fig_patient <- fig_patient + guides(linetype = guide_legend(keywidth = 3, keyheight = 1))
fig_patient
ggsave(filename = "IndivModularity.pdf", plot = fig_patient, width=8, height=8) 


# plot hemm diff
#THData$Modularity_hemispheric_diff[THData$Subject==128]<-THData[THData$Subject==128,6] - THData[THData$Subject==128,5] 
#THData$Modularity_hemispheric_diff[THData$Subject==162]<-THData[THData$Subject==162,6] - THData[THData$Subject==162,5] 
#THData$Modularity_hemispheric_diff[THData$Subject==163]<-THData[THData$Subject==163,5] - THData[THData$Subject==163,6] 
#THData$Modularity_hemispheric_diff[THData$Subject==168]<-THData[THData$Subject==168,5] - THData[THData$Subject==168,6] 
#THData$Modularity_hemispheric_diff[THData$Subject==176]<-NA

#ControlHemmDiffDATA <- subset(DATA, Group =='Young_Controls')
#ControlHemmDiffDATA$Modularity_hemispheric_diff <- ControlHemmDiffDATA$Modulairty_Left_Hemisphere-ControlHemmDiffDATA$Modularity_Right_Hemisphere
# calculate summary statistics of the Modularity data
#summaryControlHemDiffDATA <- ddply(ControlHemmDiffDATA, c('Group', 'Density'), summarise,
#                     N = sum(!is.na(Modularity_hemispheric_diff)),
#                     mean = mean(Modularity_hemispheric_diff, na.rm=TRUE),
#                     sd = sd(Modularity_hemispheric_diff, na.rm=TRUE),
#                     se = sd/ sqrt(N),
#                     upperSE = mean(Modularity_hemispheric_diff, na.rm=TRUE) + se, #*clearsd(Modularity, na.rm=TRUE),
#                     lowerSE = mean(Modularity_hemispheric_diff, na.rm=TRUE) - se,
#                     upperCI = mean(Modularity_hemispheric_diff, na.rm=TRUE) + 1.5*sd(Modularity_hemispheric_diff, na.rm=TRUE),
#                     lowerCI = mean(Modularity_hemispheric_diff, na.rm=TRUE) - 1.5*sd(Modularity_hemispheric_diff, na.rm=TRUE))

#Fig_hemdiff <- ggplot(data=summaryControlHemDiffDATA , aes(x=Density, y=mean)) + theme_classic(base_size = 24) 
#Fig_hemdiff <- Fig_hemdiff + geom_line(data=summaryControlHemDiffDATA , aes(x=Density, y=mean,  color=Group), size = 2, inherit.aes=FALSE) + scale_colour_manual(values=c(BlueScale[2:6],"#666666"))
#Fig_hemdiff <- Fig_hemdiff + geom_ribbon(data = summaryControlHemDiffDATA, aes( ymin=upperCI, ymax=lowerCI, x=Density, fill='Control CI (1.5 SD)' ), alpha = 0.15, inherit.aes=FALSE) 
#Fig_hemdiff <- Fig_hemdiff + geom_line(data=THData, aes(x=Density, y=Modularity_hemispheric_diff, color=Subject ), size = 2)  
#Fig_hemdiff <- Fig_hemdiff + labs(y = "Hemi differences in Modularity") + labs(Color='') + labs(fill='') 
#Fig_hemdiff <- Fig_hemdiff + guides(linetype = guide_legend(keywidth = 3, keyheight = 1))
#Fig_hemdiff
#ggsave(filename = "HemiDiffModularity.pdf", plot = Fig_hemdiff, width=8, height=8) 

# plot nodal data
#NodalDATA = read.csv("/Volumes//neuro/NodalGraphData.csv", header=TRUE);
#NodalDATA$Subject <- as.factor(NodalDATA$Subject)

plotData<-melt(data=NodalDATA, id.vars=c("Subject","Density"), measure.vars = c("Cortical_Target_Weight", "Cortical_nonTarget_Weight"))
labelcolors <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442")

fig_nodal <- ggplot(data=plotData , aes(x=Density, y=value, color = variable))  + facet_wrap(~Subject)  
fig_nodal <- fig_nodal + geom_line(size =2) + theme_classic(base_size = 14) + scale_colour_manual(values=labelcolors[3:4])
fig_nodal <- fig_nodal + guides(linetype = guide_legend(keywidth = 2, keyheight = 1))+ labs(y = "Z score") + labs(linetype='thalamic patients') 
#fig_nodal <- fig_nodal + ggtitle('Cortical Target Connectivity Weight')
fig_nodal 
ggsave(filename = "CorticalTarget_Weight.pdf", plot = fig_nodal, width=13, height=4) 


# plot NMI of community assignment

#fig_nodal <- fig_nodal + geom_line(data=ComparisonDATA , aes(x=Density, y=mean,  color=Group), size = 2, inherit.aes=FALSE) + scale_colour_manual(values=c(BlueScale[2:6],"Yellow","#888888"))
#fig_nodal <- fig_nodal + geom_ribbon(data = ControlDATA, aes( ymin=upperCI, ymax=lowerCI, x=Density, fill='Control CI (1.5 SD)' ), alpha = 0.15, inherit.aes=FALSE) + scale_fill_manual(values=c("Black","Yellow", "Blue","#888888")) 
#fig_nodal <- fig_nodal + geom_line(data=THData, aes(x=Density, y=Modularity, color=Subject ), size = 2)  
#fig_nodal <- fig_nodal + labs(y = "Modularity") + labs(Color='') + labs(fill='') 
#fig_nodal <- fig_nodal + guides(linetype = guide_legend(keywidth = 3, keyheight = 1))
#fig_nodal
#ggsave(filename = "IndivModularity.pdf", plot = fig_nodal, width=8, height=8) 