# install.packages("plyr")
# install.packages("dplyr")
library(dplyr)
library(readr)

gq_blk10 <- read_csv("./rawdata/nhgis0011_ts_geog2010_blck_grp.csv")
xwalk_maz_blkgrp10 <- read_csv("./rawdata/MAZ_BKGP_XWALK.csv")
xwalk_taz_maz_blk10 <- read_csv("./rawdata/GeogXWalk2010_Blocks_MAZ_TAZ.csv")
xwalk_taz_maz_blk00 <- read_csv("./rawdata/GeogXWalk2000_Blocks_MAZ_TAZ.csv")
maz <- read_csv("../maz.csv")

ba_gq_blk10 <- filter(gq_blk10, STATEA == '06' & COUNTYA %in% c('075', '081', '085', '001', '013', '095', '055', '097', '041'))
str(ba_gq_blk10)

tazmazblk10 <- left_join(xwalk_taz_maz_blk10, ba_gq_blk10, by = c("GEOID10" = "GISJOIN"))



# make 6-digit NAICS
est15_esri_raw$naicssix = est15_esri_raw$NAICS %/% 100
est15_esri_raw$emp <- as.integer(est15_esri_raw$EMPNUM)
summary(est15_esri_raw)
str(eca_gq_blk10)


# drop missing

sum <- est15_codes %>%
  group_by(MAZ, shcat) %>%
  tally(emp)

summary(sum)

e_ag <- filter(sum, shcat == 'ag')
e_ag <- transmute(e_ag,
                  e_ag = n)


# redo w maz geog attr not geofile cause geofile has 2 extra records that must be duplicates

mazlist <- select(maz, MAZ)

est15_maz <- full_join(mazlist, e_ag, by = "MAZ")


est15_maz[is.na(est15_maz)] <- 0 


write_csv(est15_maz, "/Volumes/osaka/w/land_use_zones/out/emp15_shcat_maz.csv" )


