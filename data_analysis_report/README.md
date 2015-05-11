# Example Data analysis report.

An example of a data analysis report generated for a collaborator working on a
prostate cancer study.  The data set is fictious and this example report is
provided as an example of reproducable report writting in R, LaTeX, and put
together via knitr.

See <a> https://github.com/dewitpe/newproject </a> for repo to generate the
following directory structure.

## Directory Structure

### subdirectories
* /cache - cached R chunks, md5sums for the data read script

* /data  - store the raw data and the cleaned data for analysis in the .RData file

* /figure - images for the manuscript and figures generated from the data analysis report.

* /html   - html versions of the tables from the MAIN.pdf report.

* /R      - any specific R only scripts, e.g., data read

* /references - literature relevant to this project and .bib files.

* /Rnw    - .Rnw files for the data analysis report.  These files are the primary files for editing

* /tex    - .tex files resulting from the analysis and knitting of the .Rnw files.

### Other subdirectories 
* /power  - power and sample size calculations

* /doc    - manuscript drafts

### files in the primary directory
* build.R - R script for building the report

* MAIN.pdf - data analysis report

* MAIN.log - log file from compiling the LaTeX

* report.sh - bash script for generating the report.zip file

* report.zip - a zip file with the analysis report, graphics, and html tables to
send to collaborators.

## Compiling the Report

See the file build.R for details on compiling the report.  
The build.R script loads the needed libraries for the analysis, checks if any
edits have been made to the data read script, and if so, to rerun the data read
script and load the .RData file.  The data read is excluded from .Rnw files as
the time to read in larger data sets and clean the data every time the report is
compiled can be costly.  Clearing the whole cache directy is also done at this
time to insure the data analysis is done on the correct data set.

Following the data load, all the .Rnw files in the Rnw/ subdirectory are knitted
with the output .tex files placed in the tex/ subdirectory.  Finally a system
call is made to pdflatex to compile the .pdf.



### To generate the MAIN.pdf file run the following from the command line.

`R -e "source('build.R'); knitall(); compile()`

### To build the report.zip file to send to collaborators 
run the `report.sh` script.

