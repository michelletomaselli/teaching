FROM debian:stable

LABEL maintainer "you <your_email>" \
      version "0.1" \
      description "your_description"

# Install R
RUN apt-get update && apt-get install -y r-base

# Install R package 'optparse'
RUN R -e 'install.packages("optparse", repos = "http://cloud.r-project.org/")'

RUN mkdir /scripts

ADD scripts/script.R /scripts

RUN chmod +x /scripts/script.R

ENV PATH=$PATH:/scripts
