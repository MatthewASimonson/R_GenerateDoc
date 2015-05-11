################################################################################
### file:   build.R
### author: Peter DeWitt, peter.dewitt@ucdenver.edu
### date:   November 2013
###
### For: example of a data analysis report
###
### set working directory in R to 
### setwd("<project directory>")
###
### Please try to follow the Google R Style Guide.
### http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html
###
### This file should be do the following:
###  0) Library Loads for the project.  
###  1) Remove (delete) all objects so that during compile there is no error
###     resulting from carry over in developement
###  2) Define constants for the project, such as digits to display and 
###     the alpha value
###
### To use this file: from the command line, on the working directory
### R -e "source('build.R'); knitall(); compile()"
###
### Change Log 
### 13 Nov 2013 - file created
###
################################################################################   

################################################################################
### LIBRARY LOADS - 
################################################################################
library(knitr)
library(survival)
library(Hmisc)
library(qwraps)  # not on CRAN, see github.com/dewittpe/qwraps
library(ggplot2)
library(multcomp)

################################################################################
### Remove all objects from the R session and define constants, load custom
### functions here as well.
###
################################################################################
options(qwraps.digits = 2)
options(qwraps.pdigits = 3)
options(qwraps.show.ci = TRUE)
options(qwraps.show.pval = TRUE)      
options(qwraps.alpha = 0.05)

# load the datasets for the project
if (file.exists("cache/data_read_md5sum.txt")) {
  md5 <- scan("cache/data_read_md5sum.txt", what = "character")
} else {
  md5 <- "NOFILE"
}

if (md5 != tools::md5sum("R/data_read.R")) {
  source("R/data_read.R")
  unlink("cache/")
  write(tools::md5sum("R/data_read.R"), file = "cache/data_read_md5sum.txt")
}

rm(list = objects())
load("data/primary_data.RData") 

################################################################################
### knitr 
### Dig into the ./Rnw directory and list all files with a .Rnw extension
### and run knitr() outputing .R files to the ./R directory and
### .tex files to the ./tex directory
###
### Compile of the files will be done by default in alphabetical order.
###
### There are other options, such as using child files, but this method works
### well for the file structure I am using
################################################################################
rnw.files <- list.files(path = 'Rnw/', pattern = ".Rnw$")
rnw.files <- gsub('.Rnw', '', rnw.files)

opts_chunk$set(fig.align = "center",
               fig.pos   = "!htp",
               dev       = "pdf",
               message   = FALSE, 
               tidy      = FALSE,
               echo      = FALSE,
               results   = "hide")
opts_knit$set(eval.after = "fig.cap")

knitone <- function(x) {
  knit(input  = paste0("Rnw/", x, ".Rnw"),
       output = paste0("tex/", x, ".tex"),
       tangle = FALSE)
}

knitall <- function() {
  lapply(rnw.files, knitone)
}

################################################################################
### compile the LaTeX to pdf and place the resulting file in the working 
### directory.
###
################################################################################
compile <- function(){
    system("pdflatex tex/MAIN.tex 
            bibtex MAIN.aux
            pdflatex tex/MAIN.tex 
            pdflatex tex/MAIN.tex
            rm MAIN.aux MAIN.bbl MAIN.blg MAIN.out MAIN.toc MAIN.lot MAIN.lof")
}

################################################################################
### End of File ### ### End of File ###  ### End of File ### ### End of File ###
################################################################################
