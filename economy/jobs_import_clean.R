install.packages("dplyr")

est15_esri_raw = read.csv("./rawdata/est15_esri_raw.csv", header = TRUE)
naics_recode = read.csv("naics_recode.csv", header = TRUE)

(est15_codes <- left_join(est15_esri_raw, naics_recode))