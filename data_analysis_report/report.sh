#!/bin/bash
R -e "source('build.R'); knitall(); compile()"

cd html

sh build.sh

cd ..

zip report.zip MAIN.pdf figure/*.pdf html/tables.html html/tables.css

