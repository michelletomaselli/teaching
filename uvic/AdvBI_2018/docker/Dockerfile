FROM ubuntu:16.04

LABEL maintainer "Diego Garrido Martín <diego.garrido@crg.eu>" \
      version "1.0" \
      description "Teaching - software for eQTL mapping"

## Get basic tools

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | tee -a /etc/apt/sources.list \
    && gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 \
    && gpg -a --export E084DAB9 | apt-key add -

ENV R_BASE_VERSION 3.4.4

RUN apt-get update --fix-missing -qq && apt-get install -y -q \
    wget \
    git-all \
    libgsl-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libnlopt-dev \
    r-base=${R_BASE_VERSION}* \
    && apt-get clean \
    && apt-get purge \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Make folder to contain the software
RUN mkdir software

## Install QTLtools
RUN cd software \
    && wget --quiet https://qtltools.github.io/qtltools/binaries/QTLtools_1.1_Ubuntu16.04_x86_64.tar.gz \
    && tar zxf QTLtools_1.1_Ubuntu16.04_x86_64.tar.gz \
    && chmod +x QTLtools_1.1_Ubuntu16.04_x86_64 \
    && ln -s /software/QTLtools_1.1_Ubuntu16.04_x86_64 /usr/local/bin/QTLtools

## Install Caviar
RUN cd software \
    && git clone https://github.com/fhormoz/caviar \
    && cd caviar/CAVIAR-C++ \
    && make \
    && chmod +x CAVIAR eCAVIAR \
    && ln -s /software/caviar/CAVIAR-C++/CAVIAR /usr/local/bin/CAVIAR \
    && ln -s /software/caviar/CAVIAR-C++/eCAVIAR /usr/local/bin/eCAVIAR

## Install PLINK
RUN cd software \
    && mkdir PLINK \
    && cd PLINK \
    && wget --quiet https://www.cog-genomics.org/static/bin/plink180807/plink_linux_x86_64.zip \
    && unzip plink_linux_x86_64.zip \
    && chmod +x plink \
    && ln -s /software/PLINK/plink /usr/local/bin/plink

## Install BCFtools
RUN cd software \
    && wget --quiet https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2 \
    && tar jxf bcftools-1.9.tar.bz2 \
    && cd bcftools-1.9 \
    && ./configure --prefix=$PWD \
    && make \
    && make install \
    && ln -s /software/bcftools-1.9/bcftools /usr/local/bin/bcftools

## Install BEDtools
RUN cd software \
    && wget --quiet https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz \
    && tar -zxvf bedtools-2.25.0.tar.gz \
    && cd bedtools2 \
    && make \
    && ln -s /software/bedtools2/bin/bedtools /usr/local/bin/bedtools

## Install HTSlib
RUN cd /software/bcftools-1.9/htslib-1.9 \
    && ./configure --prefix=$PWD \
    && make \
    && ln -s /software/bcftools-1.9/htslib-1.9/tabix /usr/local/bin/tabix \
    && ln -s /software/bcftools-1.9/htslib-1.9/bgzip /usr/local/bin/bgzip

## Install R packages
RUN R -e 'install.packages(c("optparse", "data.table", "ggplot2", "dplyr"), repos = "http://cloud.r-project.org/")'
RUN R -e 'source("https://bioconductor.org/biocLite.R"); biocLite(c("GenomicRanges", "Rsamtools", "preprocessCore", "variancePartition"))'
RUN wget --quiet https://cran.r-project.org/src/contrib/Archive/GenABEL/GenABEL_1.8-0.tar.gz \
    && wget --quiet https://cran.r-project.org/src/contrib/Archive/GenABEL.data/GenABEL.data_1.0.0.tar.gz \
    && R CMD INSTALL GenABEL.data_1.0.0.tar.gz \
    && R CMD INSTALL GenABEL_1.8-0.tar.gz
RUN wget --quiet https://github.com/downloads/PMBio/peer/R_peer_source_1.3.tgz \
    && R CMD INSTALL R_peer_source_1.3.tgz
