renv::activate()
here::i_am('R/Counts_By_Week.R')

# This script calculates the weekly counts of each speciations in each device
library(data.table)
library(dplyr)
library(lubridate)

NAB <- fread(here::here('processed_data','NAB_new_name.csv'))
APS_300 <- fread(here::here('processed_data','APS_300_new_name.csv'))

# Create Week Variable in each dataset
NAB$week <- gsub(' 0:00','',NAB$Date) %>% as.Date(format='%m/%d/%Y') %>% week()
APS_300$week <- week(APS_300$StartingAt)

NAB_cleant <- NAB[,-c(1,2)] # Remove 'DeviceID' and 'Date'
APS_300_cleant <- APS_300[,-c(1,2)] # Remove 'DeviceID' and 'StartingAt'

### sum all column to calculate total count of the week
NAB_by_week <- group_by(NAB_cleant,week) %>%
  summarise_all(mean)

APS_300_by_week <- group_by(APS_300_cleant,week) %>%
  summarise_all(mean)

NAB_by_week %>% write.csv(here::here('output','NAB_counts_by_week.csv'),row.names = F)
APS_300_by_week %>% write.csv(here::here('output','APS_300_counts_by_week.csv'),row.names = F)
