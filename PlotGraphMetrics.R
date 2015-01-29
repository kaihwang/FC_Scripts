# script to plot graph data

# import libraries
library(ggplot2)
library(plyr)

# read global graph data
DATA = read.csv("~/Google Drive/Projects/Thalamus-Rest/GlobalGraphData.csv", header=TRUE);



# two color scheme to use. 
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
cPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


# calculate summary statistics of the weight data
summaryDATA <- ddply(DATA, c('Group', 'Density'), summarise,
                             N = sum(!is.na(Weight)),
                             mean = mean(Weight, na.rm=TRUE),
                             sd = sd(Weight, na.rm=TRUE),
                             se = sd/ sqrt(N),
                             upperSE = mean(Weight, na.rm=TRUE) + se, #*clearsd(Weight, na.rm=TRUE),
                             lowerSE = mean(Weight, na.rm=TRUE) - se,
                             upperCI = mean(Weight, na.rm=TRUE) + 1.5*sd(Weight, na.rm=TRUE),
                             lowerCI = mean(Weight, na.rm=TRUE) - 1.5*sd(Weight, na.rm=TRUE))
              

# subsetting by dropping connectome subjects



# plot weight data
fig_weight <- ggplot(data=summaryDATA, aes(x=Density, y=mean))+ theme_classic(base_size = 24) + scale_colour_manual(values=cbbPalette) 
fig_weight <- fig_weight + geom_line(aes(color=Group), size = 2)
fig_weight <- fig_weight + geom_ribbon(data = summaryDATA, aes(fill=Group, ymin=upperSE, ymax=lowerSE, x=Density ), alpha = 0.35)
fig_weight <- fig_weight + labs(y = "Weight")
fig_weight


# plot modulairty against young controls
ControlDATA <- subset(summaryDATA, Group=='Young_Controls')
fig_modularity <- ggplot(data=ControlDATA, aes(x=Density, y=mean)) + theme_classic(base_size = 24) + scale_colour_manual(values=cPalette) 
fig_modularity <- fig_modularity + geom_line(aes(color=Group), size = 2)
fig_modularity <- fig_modularity + geom_ribbon(data = ControlDATA, aes(fill=Group, ymin=upperCI, ymax=lowerCI, x=Density ), alpha = 0.35)
fig_modularity <- fig_modularity + labs(y = "Weight")

PatientData <- subset(DATA, Group =='Thalamic_Patients')

fig_modularity <- fig_modularity + geom_line(data=PatientData, aes(x=Density, y=Weight, linetype = Subject), colour='blue', size = 2)
fig_modularity

#p2 <- ggplot(data=OurDATA, aes(x=Density, y=Weight)) 
#p2 + geom_smooth(aes(color=Group), method = "lm", size = 2, se = TRUE
#                 ) + theme_classic(base_size = 24) + scale_colour_manual(values=cPalette)

