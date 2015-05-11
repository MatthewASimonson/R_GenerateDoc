################################################################################
# file:      data_read.R
# author(s): Peter DeWitt, peter.dewitt@ucdenver.edu
#
# for:  data read for the example data analysis project
#
# change log:
# 13 November 2013 - flle created
#
################################################################################

# libraries needed only for this data read and not the data analysis.  (Not
# needed for this example, but for reading .xlsx files the XLConnect library is
# very helpful
#
# options(java.parameters = "-Xmx1024m")
# library(XLConnect)

prostate <- read.csv(file = "data/prostate.csv", header = TRUE)

# view the structure of the data.  Since the chunk option include = FALSE, no
# output form this chunk will be placed in the output file.  
str(prostate)

# clean/reformat the data set.  Set categories for the age of patients
# factor the era of treatment, PSA values, and Gleason score.  Factor, and
# rename the T.Stage (note the capitalization of Stage)
prostate <- within(prostate, 
                   {
                     Age <- cut(Age, 
                                breaks = c(min(Age), 50, 70, max(Age)), 
                                include.lowest = TRUE, 
                                right = FALSE)
                     Era <- factor(Era, 1:2, paste("Era", 1:2))
                     PSA <- factor(PSA, 1:3, c("[0, 10) ng/ml", 
                                               "[10, 20) ng/ml",
                                               "[20, Inf) ng/ml"))
                     Gleason <- factor(Gleason, 1:4, paste("GS", 7:10))
                     T.Stage <- factor(T.stage, 1:3, 
                                       paste("T Stage", c("1", "2", "3/4")))
                     rm(T.stage) 
                   })

# create a PCSS.status, prostate cancer specific survival.
prostate$PCSS.Time   <- prostate$OS.Time
prostate$PCSS.Status <- prostate$OS.Status
idx <- prostate$PCSS.status == 1
prostate$PCSS.status[idx] <- rbinom(sum(idx), 1, 0.8)

# Gleason 7
prostate$Gleason7 <- as.character(prostate$Gleason)
idx <- prostate$Gleason == "GS 7"
prostate$Gleason7[idx] <- rbinom(sum(idx), 1, 0.4)
table(prostate$Gleason7)
prostate$Gleason7 <- factor(prostate$Gleason7,
                            levels = c("0", "1", paste("GS", 8:10)),
                            labels = c("GS 7 (3+4)", "GS 7 (4+3)", 
                                       paste("GS", 8:10)))

# double check the structure of the data.frame prostate.
str(prostate)
summary(prostate)

save(prostate, file = "data/primary_data.RData")

################################################################################
# End of File 
################################################################################

