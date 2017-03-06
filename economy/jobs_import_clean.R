# install.packages("plyr")
# install.packages("dplyr")
library(dplyr)
library(readr)

est15_esri_raw <- read_csv("/Volumes/osaka/w/land_use_zones/economy/rawdata/est15_esri_raw.csv")
naics_recode <- read_csv("/Volumes/osaka/w/land_use_zones/economy/naics_recode.csv")
geofile <- read_csv("/Volumes/osaka/w/land_use_zones/geofile.csv")
maz <- read_csv("/Volumes/osaka/w/land_use_zones/maz.csv")

# make 6-digit NAICS
est15_esri_raw$naicssix = est15_esri_raw$NAICS %/% 100
est15_esri_raw$emp <- as.integer(est15_esri_raw$EMPNUM)
summary(est15_esri_raw)
str(est15_esri_raw)

est15_codes <- left_join(est15_esri_raw, naics_recode, by = "naicssix")

# drop missing

  sum <- est15_codes %>%
  group_by(MAZ, shcat) %>%
  tally(emp)

summary(sum)

e_ag <- filter(sum, shcat == 'ag')
e_ag <- transmute(e_ag,
                    e_ag = n)
e_natres <- filter(sum, shcat == 'natres')
e_natres <- transmute(e_natres,
                  e_natres = n)
e_util <- filter(sum, shcat == 'util')
e_util <- transmute(e_util,
          e_util = n)
e_constr <- filter(sum, shcat == 'constr')
e_constr <- transmute(e_constr,
                    e_constr = n)
e_man_lgt <- filter(sum, shcat == 'man_lgt')
e_man_lgt <- transmute(e_man_lgt,
                    e_man_lgt = n)
e_man_hvy <- filter(sum, shcat == 'man_hvy')
e_man_hvy <- transmute(e_man_hvy,
                    e_man_hvy = n)
e_man_bio <- filter(sum, shcat == 'man_bio')
e_man_bio <- transmute(e_man_bio,
                    e_man_bio = n)
e_man_tech <- filter(sum, shcat == 'man_tech')
e_man_tech <- transmute(e_man_tech,
                    e_man_tech = n)
e_logis <- filter(sum, shcat == 'logis')
e_logis <- transmute(e_logis,
                    e_logis = n)
e_ret_reg <- filter(sum, shcat == 'ret_reg')
e_ret_reg <- transmute(e_ret_reg,
                    e_ret_reg = n)
e_ret_loc <- filter(sum, shcat == 'ret_loc')
e_ret_loc <- transmute(e_ret_loc,
                    e_ret_loc = n)
e_transp <- filter(sum, shcat == 'transp')
e_transp <- transmute(e_transp,
                    e_transp = n)
e_info <- filter(sum, shcat == 'info')
e_info <- transmute(e_info,
                    e_info = n)
e_fire <- filter(sum, shcat == 'fire')
e_fire <- transmute(e_fire,
                    e_fire = n)
e_serv_pers <- filter(sum, shcat == 'serv_pers')
e_serv_pers <- transmute(e_serv_pers,
                    e_serv_pers = n)
e_lease <- filter(sum, shcat == 'lease')
e_lease <- transmute(e_lease,
                    e_lease = n)
e_prof <- filter(sum, shcat == 'prof')
e_prof <- transmute(e_prof,
                    e_prof = n)
e_serv_bus <- filter(sum, shcat == 'serv_bus')
e_serv_bus <- transmute(e_serv_bus,
                    e_serv_bus = n)
e_ed_k12 <- filter(sum, shcat == 'ed_k12')
e_ed_k12 <- transmute(e_ed_k12,
                    e_ed_k12 = n)
e_ed_high <- filter(sum, shcat == 'ed_high')
e_ed_high <- transmute(e_ed_high,
                    e_ed_high = n)
e_ed_other <- filter(sum, shcat == 'ed_other')
e_ed_other <- transmute(e_ed_other,
                    e_ed_other = n)
e_health <- filter(sum, shcat == 'health')
e_health <- transmute(e_health,
                    e_health = n)
e_serv_soc <- filter(sum, shcat == 'serv_soc')
e_serv_soc <- transmute(e_serv_soc,
                    e_serv_soc = n)
e_art_rec <- filter(sum, shcat == 'art_rec')
e_art_rec <- transmute(e_art_rec,
                    e_art_rec = n)
e_hotel <- filter(sum, shcat == 'hotel')
e_hotel <- transmute(e_hotel,
                    e_hotel = n)
e_eat <- filter(sum, shcat == 'eat')
e_eat <- transmute(e_eat,
                    e_eat = n)
e_gov <- filter(sum, shcat == 'gov')
e_gov <- transmute(e_gov,
                    e_gov = n)
e_mis <- filter(sum, shcat == 'mis')
e_mis <- transmute(e_mis,
                    e_mis = n)

# redo w maz geog attr not geofile cause geofile has 2 extra records that must be duplicates

mazlist <- select(maz, MAZ)

est15_maz <- full_join(mazlist, e_ag, by = "MAZ")
est15_maz <- full_join(est15_maz, e_natres, by = "MAZ")
est15_maz <- full_join(est15_maz, e_util, by = "MAZ")
est15_maz <- full_join(est15_maz, e_constr, by = "MAZ")
est15_maz <- full_join(est15_maz, e_man_lgt, by = "MAZ")
est15_maz <- full_join(est15_maz, e_man_hvy, by = "MAZ")
est15_maz <- full_join(est15_maz, e_man_bio, by = "MAZ")
est15_maz <- full_join(est15_maz, e_man_tech, by = "MAZ")
est15_maz <- full_join(est15_maz, e_logis, by = "MAZ")
est15_maz <- full_join(est15_maz, e_ret_reg, by = "MAZ")
est15_maz <- full_join(est15_maz, e_ret_loc, by = "MAZ")
est15_maz <- full_join(est15_maz, e_transp, by = "MAZ")
est15_maz <- full_join(est15_maz, e_info, by = "MAZ")
est15_maz <- full_join(est15_maz, e_fire, by = "MAZ")
est15_maz <- full_join(est15_maz, e_serv_pers, by = "MAZ")
est15_maz <- full_join(est15_maz, e_lease, by = "MAZ")
est15_maz <- full_join(est15_maz, e_prof, by = "MAZ")
est15_maz <- full_join(est15_maz, e_serv_bus, by = "MAZ")
est15_maz <- full_join(est15_maz, e_ed_k12, by = "MAZ")
est15_maz <- full_join(est15_maz, e_ed_high, by = "MAZ")
est15_maz <- full_join(est15_maz, e_ed_other, by = "MAZ")
est15_maz <- full_join(est15_maz, e_health, by = "MAZ")
est15_maz <- full_join(est15_maz, e_serv_soc, by = "MAZ")
est15_maz <- full_join(est15_maz, e_art_rec, by = "MAZ")
est15_maz <- full_join(est15_maz, e_hotel, by = "MAZ")
est15_maz <- full_join(est15_maz, e_eat, by = "MAZ")
est15_maz <- full_join(est15_maz, e_gov, by = "MAZ")
est15_maz <- full_join(est15_maz, e_mis, by = "MAZ")

est15_maz[is.na(est15_maz)] <- 0 


write_csv(est15_maz, "/Volumes/osaka/w/land_use_zones/out/emp15_shcat_maz.csv" )




# select to clean if needed

# arrange to sort

                        
                                                                  

#adjust
               