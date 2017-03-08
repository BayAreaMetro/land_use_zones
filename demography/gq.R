# install.packages("plyr")
# install.packages("dplyr")
install.packages("strngr")
library(dplyr)
library(readr)

gq_blk10 <- read_csv("./rawdata/gq10_blk.csv")
gq_blk00 <- read_csv("./rawdata/gq00_blk.csv")
gq_blkgrp10 <- read_csv("./rawdata/nhgis0011_ts_geog2010_blck_grp.csv")
gq_add <- read_csv("gq_add_00051015.csv")
xwalk_maz_blkgrp10 <- read_csv("./rawdata/MAZ_BKGP_XWALK.csv")
xwalk_taz_maz_blk10 <- read_csv("./rawdata/GeogXWalk2010_Blocks_MAZ_TAZ.csv")
xwalk_taz_maz_blk00 <- read_csv("./rawdata/GeogXWalk2000_Blocks_MAZ_TAZ.csv")
maz <- read_csv("../maz.csv")

ba_gq_blkgrp10 <- filter(gq_blkgrp10, STATEA == '06' & COUNTYA %in% c('075', '081', '085', '001', '013', '095', '055', '097', '041'))
str(ba_gq_blkgrp10)
rename(ba_gq_blkgrp10, gq_univ10 = CQ2AD2010)
r

# xwalk_taz_maz_blk10$GISJOIN <- paste("G", xwalk_taz_maz_blk10$GEOID10, sep="")
# xwalk_taz_maz_blk10$gisjoin <- tail(xwalk_taz_maz_blk10$GEOID10, 13)


substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
ba_gq_blk10$gj <- substrRight(ba_gq_blk10$GISJOIN, 6)


tazmazblk10 <- left_join(xwalk_taz_maz_blk10, gq_blk10, by = c("GEOID10" = "GEOID10"))
gq10c <- select(tazmazblk10, MAZ_ORIGINAL, gq_inst, gq_univ10, gq_mil10, gq_othnon10)
gq10 <- gq10c %>%
  group_by(MAZ_ORIGINAL) %>%
  summarize_each(funs(sum))
                           
tazmazblk00 <- left_join(xwalk_taz_maz_blk00, gq_blk00, by = c("BLKIDFP00" = "BLKIDFP00"))
gq00c <- select(tazmazblk00, MAZ_ORIGINAL, gq_inst00, gq_univ00, gq_mil00, gq_othnon00)
gq00 <- gq00c %>%
  group_by(MAZ_ORIGINAL) %>%
  summarize_each(funs(sum))

gq <- left_join(maz, gq10, by = c("MAZ" = "MAZ_ORIGINAL"))
gq <- left_join(gq, gq00, by = c("MAZ" = "MAZ_ORIGINAL"))
gq <- left_join(gq, gq_add, by = c("MAZ" = "MAZ"))

gq$univ15 <- gq$gq_univ10 + gq$add_univ_1015
gq$mil15 <- gq$gq_mil10 + gq$add_mil_1015
gq$othnon15 <- gq$gq_othnon10 + gq$add_othnon_1015

gq$univ10 <- gq$gq_univ10
gq$mil10 <- gq$gq_mil10
gq$othnon10 <- gq$gq_othnon10

gq$univ05 <- gq$gq_univ10 - gq$add_univ_0510
gq$mil05 <- gq$gq_mil10 - gq$add_mil_0510
gq$othnon05 <- gq$gq_othnon10 - gq$add_othnon_0510

gq$univ00 <- gq$univ05 - gq$add_univ_0005
gq$mil00 <- gq$gq_mil00
gq$othnon00 <- gq$othnon05 + gq$add_othnon_0005

gq_out <- select(gq, MAZ, univ15, mil15, othnon15,univ10, mil10, othnon10, univ05, mil05, othnon05, univ00, mil00, othnon00)


#      univ mil oth inst 
# adj    man  none 0.97   
# 15    40266 1959 44800 55778                     (114951 in 1 yr acs)
# 10    39933 1959 46310 59478 = 147,680 (137800 in 1 yr acs)
# 00    25103 2931 47820 66934 = 
#       man   none 1.03







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


