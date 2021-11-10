renv::restore()
here::i_am('R/Weekly_Plot.R')

# This script draw the barplots to compare the identified top5 speciations of pollen
# of each device of NAB and APS-300 during the pollen peak period (Week 10 to 16)
library(ggplot2)
library(data.table)
library(lubridate)
library(dplyr)
library(reshape2)
library(plyr)
library(viridis)
library(RColorBrewer)
library(stringr)

#### Read datasets
NAB_by_week <- fread(here::here('output','NAB_counts_by_week.csv'))
APS_300_by_week <- fread(here::here('output','APS_300_counts_by_week.csv'))

### Assign device name before merge datasets
NAB_by_week$device <- rep('NAB',nrow(NAB_by_week))
APS_300_by_week$device <- rep('APS-300',nrow(APS_300_by_week))

### Filter the week 10 to week 17
NAB_by_week_10_17 <- NAB_by_week[NAB_by_week$week>=10 &
                                   NAB_by_week$week<=17,]

APS_300_by_week_10_17 <- APS_300_by_week[APS_300_by_week$week>=10 &
                                           APS_300_by_week$week<=17,]

#### Keep dominent species cols.
APS_300_by_week_10_17 <- APS_300_by_week_10_17[,-c(2:7,32)]
colnames(APS_300_by_week_10_17)[colnames(APS_300_by_week_10_17)=='Total2'] <- 'Total'

### Merge two dataset
combined <- rbind.fill(APS_300_by_week_10_17,NAB_by_week_10_17)

combined_subset_t<- as.data.frame(t(combined[,c(2:24,27:43)]))

speciation_df <- data.frame()

### A dummy for loop to select top 5 value in each col
for (i in 1:ncol(combined_subset_t)){
  single_col <- combined_subset_t[,i]
  single_col_p <- rep(0,length(single_col))
  single_col_p[rank(-single_col,na.last = T)<=5] <- single_col[rank(-single_col,na.last = T)<=5]
  speciation_df<-rbind(speciation_df,t(single_col_p))
}

colnames(speciation_df) <- colnames(combined)[c(2:24,27:43)]

### Calculate the sum of top 5 speciation for calculating the others for each week
speciation_df$top5 <- rowSums(speciation_df)

speciation_df$week <- combined$week
speciation_df$device <- combined$device
speciation_df$total <- combined$Total
speciation_df$others <- speciation_df$total - speciation_df$top5 

speciation_df[speciation_df==0] <- NA

final <- speciation_df[, colSums(is.na(speciation_df)) != nrow(speciation_df)]
colnames(final) <- tolower(colnames(final))

### Vertical to long
final <- melt(final,id.vars = c('week','device'))

colnames(final)[3] <- 'speciation'

final_0NA <- na.omit(final)
final_0NA <- final_0NA[final_0NA$speciation!='total' &
                         final_0NA$speciation!='top5',]

final_0NA$week <- paste('week',final_0NA$week,sep=' ')

### Plot
png(here::here('Rmd','bar_chart_APS_VS_NAB_Average.png'),width = 2048,height=2048*0.6)

ggplot(final_0NA,aes(x=device,y=value,fill=speciation)) + 
  geom_bar(colour='grey',stat='identity',position=position_stack()) +
  facet_grid(~week) + scale_fill_viridis_d(direction = -1) + 
  theme_classic() + 
  xlab('Method') + ylab('Mean pollen count') + 
  theme(text = element_text(size=45),
        axis.text.x = element_text(angle=45,hjust = 1),
        axis.title.x = element_text(vjust=-2),
        plot.margin = unit(c(50,50,50,50),'pt'),
        axis.title.y = element_text(vjust=2),
        panel.border = element_rect(fill=NA),
        panel.grid.major.x = element_line(size=1.5,linetype = 'dashed'),
        panel.grid.major.y = element_line(size=2))

dev.off()

