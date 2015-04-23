# script to plot graph data
setwd("~/Google Drive/Projects/Thalamus-Rest/")

# import libraries
library(ggplot2)
library(plyr)
library(reshape2)
library(scales)

# read global graph data
DATA = read.csv('~/Google Drive//Projects/Thalamus-Rest/GlobalGraph.csv', header=TRUE);



# color schemes that will be using for plooting. 
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
cPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
BlueScale<-c("#f7fbff", "#deebf7", "#c6dbef", "#9ecae1", "#6baed6",  "#4292c6", "#2171b5", "#084594")
WarmScale<-c("#ffffcc","#ffeda0", "#fed976", "#feb24c", "#fd8d3c", "#fc4e2a", "#e31a1c", "#b10026")
labelcolors <- c("#e41a1c", "#377eb8", "#4daf4a", "#984ea3", "#ff7f00", "#ffff33","#a65628","#f781bf", "#d9d9d9", "#bc80bd")




## plot modularity
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
              


# plot group Modularity data
fig_group <- ggplot(data=summaryDATA, aes(x=Density, y=mean))+ theme_classic(base_size = 24) + scale_colour_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_group <- fig_group + geom_line(aes(color=Group), size = 2)
fig_group <- fig_group + geom_ribbon(data = summaryDATA, aes(fill=Group, ymin=upperSE, ymax=lowerSE, x=Density ), alpha = 0.35)+ scale_fill_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_group <- fig_group + labs(y = "Modularity")
fig_group
#ggsave(filename = "GroupModularity.pdf", plot = fig_group, width=8, height=8) 


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
#ggsave(filename = "IndivModularity.pdf", plot = fig_patient, width=8, height=8) 


## plot clustering coefficeint data
summaryDATA <- ddply(DATA, c('Group', 'Density'), summarise,
                     N = sum(!is.na(Clustering_Coefficient)),
                     mean = mean(Clustering_Coefficient, na.rm=TRUE),
                     sd = sd(Clustering_Coefficient, na.rm=TRUE),
                     se = sd/ sqrt(N),
                     upperSE = mean(Clustering_Coefficient, na.rm=TRUE) + se, #*clearsd(Clustering_Coefficient, na.rm=TRUE),
                     lowerSE = mean(Clustering_Coefficient, na.rm=TRUE) - se,
                     upperCI = mean(Clustering_Coefficient, na.rm=TRUE) + 1.5*sd(Clustering_Coefficient, na.rm=TRUE),
                     lowerCI = mean(Clustering_Coefficient, na.rm=TRUE) - 1.5*sd(Clustering_Coefficient, na.rm=TRUE))

# plot group Clustering_Coefficient data
fig_group <- ggplot(data=summaryDATA, aes(x=Density, y=mean))+ theme_classic(base_size = 24) + scale_colour_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_group <- fig_group + geom_line(aes(color=Group), size = 2)
fig_group <- fig_group + geom_ribbon(data = summaryDATA, aes(fill=Group, ymin=upperSE, ymax=lowerSE, x=Density ), alpha = 0.35)+ scale_fill_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_group <- fig_group + labs(y = "Clustering_Coefficient")
fig_group
#ggsave(filename = "GroupClustering_Coefficient.pdf", plot = fig_group, width=8, height=8) 


# plot indiv patient modulairty against young controls
ControlDATA <- subset(summaryDATA, Group=='Young_Controls')
ComparisonDATA <- subset(summaryDATA, Group=='Young_Controls' | Group =='Thalamic_Patients')
THData <- subset(summaryDATA, Group =='Thalamic_Patients')
BGData <- subset(DATA, Group =='Striatal_Patients')

fig_patient <- ggplot(data=ControlDATA , aes(x=Density, y=mean)) + theme_classic(base_size = 24) 
fig_patient <- fig_patient + geom_line(data=ComparisonDATA , aes(x=Density, y=mean,  color=Group), size = 2, inherit.aes=FALSE) + scale_colour_manual(values=c(WarmScale,"Blue","#888888"))
fig_patient <- fig_patient + geom_ribbon(data = ControlDATA, aes( ymin=upperCI, ymax=lowerCI, x=Density, fill='Control CI (1.5 SD)' ), alpha = 0.15, inherit.aes=FALSE) + scale_fill_manual(values=c("Black","Yellow", "Blue","#888888")) 
fig_patient <- fig_patient + geom_line(data=BGData, aes(x=Density, y=Clustering_Coefficient, color=Subject ), size = 2)  
fig_patient <- fig_patient + labs(y = "Clustering_Coefficient") + labs(Color='') + labs(fill='') 
fig_patient <- fig_patient + guides(linetype = guide_legend(keywidth = 3, keyheight = 1))
fig_patient
#ggsave(filename = "IndivClustering_Coefficient.pdf", plot = fig_patient, width=8, height=8) 



## plot hemispheric difference in modularity
THData$Modularity_hemispheric_diff[THData$Subject==128]<-THData[THData$Subject==128,6] - THData[THData$Subject==128,5] 
THData$Modularity_hemispheric_diff[THData$Subject==162]<-THData[THData$Subject==162,6] - THData[THData$Subject==162,5] 
THData$Modularity_hemispheric_diff[THData$Subject==163]<-THData[THData$Subject==163,5] - THData[THData$Subject==163,6] 
THData$Modularity_hemispheric_diff[THData$Subject==168]<-THData[THData$Subject==168,5] - THData[THData$Subject==168,6] 
THData$Modularity_hemispheric_diff[THData$Subject==176]<-NA # this guy has bilateral lesion

ControlHemmDiffDATA <- subset(DATA, Group =='Young_Controls')
ControlHemmDiffDATA$Modularity_hemispheric_diff <- ControlHemmDiffDATA$Modulairty_Left_Hemisphere-ControlHemmDiffDATA$Modularity_Right_Hemisphere

# calculate summary statistics of the each hemi's modularity data
summaryControlHemDiffDATA <- ddply(ControlHemmDiffDATA, c('Group', 'Density'), summarise,
                     N = sum(!is.na(Modularity_hemispheric_diff)),
                     mean = mean(Modularity_hemispheric_diff, na.rm=TRUE),
                     sd = sd(Modularity_hemispheric_diff, na.rm=TRUE),
                     se = sd/ sqrt(N),
                     upperSE = mean(Modularity_hemispheric_diff, na.rm=TRUE) + se, #*clearsd(Modularity, na.rm=TRUE),
                     lowerSE = mean(Modularity_hemispheric_diff, na.rm=TRUE) - se,
                     upperCI = mean(Modularity_hemispheric_diff, na.rm=TRUE) + 1.5*sd(Modularity_hemispheric_diff, na.rm=TRUE),
                     lowerCI = mean(Modularity_hemispheric_diff, na.rm=TRUE) - 1.5*sd(Modularity_hemispheric_diff, na.rm=TRUE))

Fig_hemdiff <- ggplot(data=summaryControlHemDiffDATA , aes(x=Density, y=mean)) + theme_classic(base_size = 24) 
Fig_hemdiff <- Fig_hemdiff + geom_line(data=summaryControlHemDiffDATA , aes(x=Density, y=mean,  color=Group), size = 2, inherit.aes=FALSE) + scale_colour_manual(values=c(BlueScale[2:6],"#666666"))
Fig_hemdiff <- Fig_hemdiff + geom_ribbon(data = summaryControlHemDiffDATA, aes( ymin=upperCI, ymax=lowerCI, x=Density, fill='Control CI (1.5 SD)' ), alpha = 0.15, inherit.aes=FALSE) 
Fig_hemdiff <- Fig_hemdiff + geom_line(data=THData, aes(x=Density, y=Modularity_hemispheric_diff, color=Subject ), size = 2)  
Fig_hemdiff <- Figw_hemdiff + labs(y = "Hemi differences in Modularity") + labs(Color='') + labs(fill='') 
Fig_hemdiff <- Fig_hemdiff + guides(linetype = guide_legend(keywidth = 3, keyheight = 1))
Fig_hemdiff
#ggsave(filename = "HemiDiffModularity.pdf", plot = Fig_hemdiff, width=8, height=8) 


## plot nodal data
#read in nodal data
NodalDATA = read.csv('~/Google Drive//Projects/Thalamus-Rest/Nodal.csv', header=TRUE);
#NodalDATA = read.csv('/Volumes//neuro//Nodal.csv', header=TRUE);
NodalDATA$Subject <- as.factor(NodalDATA$Subject)

# plot target v non target weight
plotData<-melt(data=NodalDATA, id.vars=c("Subject","Density"), measure.vars = c("Cortical_Target_Weight", "Cortical_nonTarget_Weight"))

fig_nodal <- ggplot(data=plotData , aes(x=Density, y=value, color = variable))  + facet_wrap(~Subject, ncol = 5)  
fig_nodal <- fig_nodal + geom_line(size =2) + theme_classic(base_size = 14) + scale_colour_manual(values=labelcolors[1:2])
fig_nodal <- fig_nodal + guides(linetype = guide_legend(keywidth = 2, keyheight = 1))+ labs(y = "Z score") + labs(linetype='thalamic patients') 
fig_nodal <- fig_nodal + scale_x_continuous(breaks=pretty_breaks(n=2))
fig_nodal
ggsave(filename = "CorticalTarget_Weight.pdf", plot = fig_nodal, width=13, height=4) 

# plot between v within weight
plotData<-melt(data=NodalDATA, id.vars=c("Subject","Density"), measure.vars = c("Cortical_Target_Within_Weight", "Cortical_Target_Between_Weight"))
fig_nodal <- ggplot(data=plotData , aes(x=Density, y=value, color = variable))  + facet_wrap(~Subject, ncol = 5)  
fig_nodal <- fig_nodal + geom_line(size =2) + theme_classic(base_size = 14) + scale_colour_manual(values=labelcolors[3:4])
fig_nodal <- fig_nodal + guides(linetype = guide_legend(keywidth = 2, keyheight = 1))+ labs(y = "Z score") + labs(linetype='thalamic patients') 
fig_nodal <- fig_nodal + scale_x_continuous(breaks=pretty_breaks(n=2))
fig_nodal
ggsave(filename = "CorticalTarget_wvb_Weight.pdf", plot = fig_nodal, width=13, height=4) 

# plot within weight for target v nontarget
plotData<-melt(data=NodalDATA, id.vars=c("Subject","Density"), measure.vars = c("Cortical_Target_Within_Weight", "Cortical_nonTarget_Within_Weight"))
fig_nodal <- ggplot(data=plotData , aes(x=Density, y=value, color = variable))  + facet_wrap(~Subject, ncol = 5)  
fig_nodal <- fig_nodal + geom_line(size =2) + theme_classic(base_size = 14) + scale_colour_manual(values=labelcolors[5:6])
fig_nodal <- fig_nodal + guides(linetype = guide_legend(keywidth = 2, keyheight = 1))+ labs(y = "Z score") + labs(linetype='thalamic patients') 
fig_nodal <- fig_nodal + scale_x_continuous(breaks=pretty_breaks(n=2))
fig_nodal
ggsave(filename = "CorticalTarget_Within_Weight_TvNT.pdf", plot = fig_nodal, width=13, height=4) 

# plot between weight for target v nontarget
plotData<-melt(data=NodalDATA, id.vars=c("Subject","Density"), measure.vars = c("Cortical_Target_Between_Weight", "Cortical_nonTarget_Between_Weight"))
fig_nodal <- ggplot(data=plotData , aes(x=Density, y=value, color = variable))  + facet_wrap(~Subject, ncol = 5)  
fig_nodal <- fig_nodal + geom_line(size =2) + theme_classic(base_size = 14) + scale_colour_manual(values=labelcolors[7:8])
fig_nodal <- fig_nodal + guides(linetype = guide_legend(keywidth = 2, keyheight = 1))+ labs(y = "Z score") + labs(linetype='thalamic patients') 
fig_nodal <- fig_nodal + scale_x_continuous(breaks=pretty_breaks(n=2))
fig_nodal
ggsave(filename = "CorticalTarget_Between_Weight_TvNT.pdf", plot = fig_nodal, width=13, height=4) 

# plot PC values
plotData<-melt(data=NodalDATA, id.vars=c("Subject","Density"), measure.vars = c("Cortical_Target_PC", "Cortical_nonTarget_PC"))
fig_nodal <- ggplot(data=plotData , aes(x=Density, y=value, color = variable))  + facet_wrap(~Subject, ncol = 5)  
fig_nodal <- fig_nodal + geom_line(size =2) + theme_classic(base_size = 14) + scale_colour_manual(values=labelcolors[9:10])
fig_nodal <- fig_nodal + guides(linetype = guide_legend(keywidth = 2, keyheight = 1))+ labs(y = "Z score") + labs(linetype='thalamic patients') 
fig_nodal <- fig_nodal + scale_x_continuous(breaks=pretty_breaks(n=2))
fig_nodal
ggsave(filename = "NodalPC.pdf", plot = fig_nodal, width=13, height=4) 


## plot NMI of community assignment
# read in NMI data
NMIDATA <- read.csv('~/Google Drive//Projects/Thalamus-Rest/nmi.csv', header = TRUE)

NMIplot <- ggplot(data=NMIDATA, aes(x=Group, y=Value, color = Group)) + geom_boxplot(size=0.5)+geom_point(size=4) + scale_colour_manual(values=c("Black","Yellow", "Blue","#888888")) 
NMIplot <- NMIplot + theme_grey(base_size = 16) + labs(y="Mutual Information")
NMIplot
#ggsave(filename = "CI_NMI.pdf", plot = NMIplot, width=12, height=8) 

## plot thalamic parcellation distribution (percentage)

parcel.color <- c('#fb9a99', '#ffff00', '#0000ff', '#cab2d6', '#6a3d9a', '#ff7f00', '#e31a1c')
#parcel.header <- c('Network','Percentage')
Network <- c('Default','Somato-Motor','Auditory', 'Visual','CO','FP','DA')
Percentage <- c(13, 12.86, 0.59, 22.29,34.25,10.88,5.43)
parcel.dataframe <-data.frame(Network, Percentage)

parcel.plot <- ggplot(data=parcel.dataframe, aes(x=Network, y=Percentage)) 
parcel.plot <- parcel.plot + geom_bar(aes(fill=Network),stat='identity') + scale_fill_manual(values = parcel.color) + theme_classic(base_size = 15)
parcel.plot <- parcel.plot + theme(axis.title.x = element_blank(), axis.text.x=element_blank(), axis.ticks=element_blank())
parcel.plot
ggsave(filename = 'parcel.plot.pdf', plot = parcel.plot, width = 5, height = 8)

## plot patients thalamic voxel's community assignment
patient.parcelData <- read.csv('~/Google Drive/Projects/Thalamus-Rest/Parcels.csv', header = TRUE)
patient.parcelPlot <- ggplot(data=patient.parcelData, aes(x=Assignment, y = VoxelCount))
patient.parcelPlot <- patient.parcelPlot + geom_bar(aes(fill=Assignment), stat='identity') + scale_fill_manual(values = parcel.color) + theme_classic(base_size = 15)
patient.parcelPlot <- patient.parcelPlot + facet_wrap(~Subject, ncol = 3)  + theme(axis.title.x = element_blank(), axis.text.x=element_blank(), axis.ticks=element_blank())
patient.parcelPlot 
ggsave(filename = 'patient_parcel.plot.pdf', plot = patient.parcelPlot , width = 7, height = 8)