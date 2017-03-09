# install.packages("plyr")
# install.packages("dplyr")
install.packages("strngr")
library(dplyr)
library(readr)

hh15_pr_maz <- read_csv("./rawdata/hh_r7224c_2015_maz.csv")
hh15_mod <- read_csv("hh15_mod.csv")
maz <- read_csv("../maz.csv")

hhc <- left_join(hh15_pr_maz, hh15_mod, by = c("MAZ_ORIGINAL" = "MAZ_ORIGINAL"))
hhc[is.na(hhc)] <- 0 

hhc$HHq1 <- hhc$Sum_hhq1 + hhc$add1
hhc$HHq2 <- hhc$Sum_hhq2 + hhc$add2
hhc$HHq3 <- hhc$Sum_hhq3 + hhc$add3
hhc$HHq4 <- hhc$Sum_hhq4 + hhc$add4

hhc <- left_join(maz, hhc, by = c("MAZ" = "MAZ_ORIGINAL"))
hh_out <- select(hhc, MAZ, HHq1, HHq2, HHq3, HHq4)
hh_out[is.na(hh_out)] <- 0 


write_csv(hh_out, "../out/hh15_maz.csv" )



#      univ mil oth inst 
# adj    man  none 0.97   
# 15    40266 1959 44800 55778                     (114951 in 1 yr acs)
# 10    39933 1959 46310 59478 = 147,680 (137800 in 1 yr acs)
# 00    25103 2931 47820 66934 = 
#       man   none 1.03


