here::i_am('R/Reassign_Speciation_Name.R')

### This script renamed the pollen identified by the NAB device with the name from APS_300
library(data.table)
library(dplyr)

NAB <- fread(here::here('data','clinic_identified.csv')) ### Read NAB method raw data
APS_300 <- fread(here::here('data','182192020.csv')) ### Read APS_300 method raw data

#The relationship is corresponded to previous literactures
colnames(APS_300)[colnames(APS_300)=='Chenopodium / Amaranthus'] <- 'Chen. /Amar.'
colnames(APS_300)[colnames(APS_300)=='Pinus'] <- 'PINE'
colnames(APS_300)[colnames(APS_300)=='Quercus'] <- 'OAK'
colnames(APS_300)[colnames(APS_300)=='Salix'] <- 'WILLOW'
colnames(APS_300)[colnames(APS_300)=='Alnus'] <- 'ALDER'
colnames(APS_300)[colnames(APS_300)=='Acer'] <- 'MAPLE'
colnames(APS_300)[colnames(APS_300)=='Carya'] <- 'HICKORY'
colnames(APS_300)[colnames(APS_300)=='Cupressaceae'] <- 'JUNIPER'
colnames(APS_300)[colnames(APS_300)=='Fraxinus'] <- 'ASH'
colnames(APS_300)[colnames(APS_300)=='Morus'] <- 'MULBERRY'
colnames(APS_300)[colnames(APS_300)=='Populus'] <- 'COTTONWOOD'
colnames(APS_300)[colnames(APS_300)=='Olea'] <- 'PRIVET'
colnames(APS_300)[colnames(APS_300)=='Cyperaceae'] <- 'SEDGES'
colnames(APS_300)[colnames(APS_300)=='Betula'] <- 'BETULA'

# In analysis, we identify BIRCH and HAZELNUT as BETULA
NAB$BETULA <- NAB$BIRCH + NAB$HAZELNUT 

# Save the datasets with new names
write.csv(NAB,here::here('processed_data','NAB_new_name.csv'),row.names = F)
write.csv(APS_300,here::here('processed_data','APS_300_new_name.csv'),row.names = F)



