install.packages("dplyr")
library(dplyr)
library(readr)

est15_esri_raw <- read_csv("/Volumes/osaka/w/land_use_zones/economy/rawdata/est15_esri_raw.csv")
naics_recode <- read_csv("/Volumes/osaka/w/land_use_zones/economy/naics_recode.csv")

# make 6-digit NAICS
est15_esri_raw$naicssix = est15_esri_raw$NAICS %/% 100

est15_codes <- left_join(est15_esri_raw, naics_recode, by = "naicssix")

# drop missing





est15_summ <- ddply(est15_codes, c("maz", "shcat"), summarise,
               emp    = sum(empnum)
               
              
               
#adjust
               