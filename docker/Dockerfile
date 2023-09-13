FROM r-base

################## METADATA ######################
LABEL Name="Ryan Ames <ryan.ames@eaglegenomics.com>"
LABEL version="0.1"
LABEL software="Bulk RNA-Seq"
LABEL software.version="1.0"
LABEL about.summary="R environment for differential expression"

################## INSTALLATION ######################
RUN mkdir /home/diff-exp
WORKDIR /home/diff-exp

COPY . /home/diff-exp/

RUN apt-get -y update
RUN R -e "install.packages('BiocManager', repos='http://lib.stat.cmu.edu/R/CRAN')"
RUN R -e "BiocManager::install('edgeR')"