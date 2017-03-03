# install.packages("plyr")
# install.packages("dplyr")
library(plyr)
library(dplyr)
library(readr)

est15_esri_raw <- read_csv("/Volumes/osaka/w/land_use_zones/economy/rawdata/est15_esri_raw.csv")
naics_recode <- read_csv("/Volumes/osaka/w/land_use_zones/economy/naics_recode.csv")

# make 6-digit NAICS
est15_esri_raw$naicssix = est15_esri_raw$NAICS %/% 100

est15_codes <- left_join(est15_esri_raw, naics_recode, by = "naicssix")

# drop missing

  sumby <- est15_codes %>%
  group_by(MAZ_ORIGINAL, shcat) %>%
  tally(EMPNUM)

summary(sum)
# write_csv(sum, "/Volumes/osaka/w/land_use_zones/economy/rawdata/emp15_maz.csv" )

e_ag <- filter(sum, shcat == 'ag')
e_ag <- transmute(e_ag,
                    emp_ag = n)
e_natres <- filter(sum, shcat == 'natres')
e_natres <- transmute(e_natres,
                  emp_natres = n)
e_util <- filter(sum, shcat == 'util')
e_util <- transmute(e_util,
          emp_util = n)

est15_maz <- full_join(e_ag, e_natres, by = "MAZ_ORIGINAL")





# select to clean if needed

# arrange to sort



#########
grouped <- group_by(est15_codes$MAZ_ORIGINAL, est15_codes$shcat)



est15_summ <- ddply(est15_codes, c("maz", "shcat"), function(x) c(count=nrow(x)), emp = sum(empnum))
               
              
               

                                                                  
                                                                  

#adjust
               