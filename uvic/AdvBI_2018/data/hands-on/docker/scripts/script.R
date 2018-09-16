#!/usr/bin/Rscript

## Simple script to plot the histogram of some numbers
## Diego Garrido-Martín
## 09/09/2018

## Load libraries
library(optparse)

## Parse arguments
option_list = list(
  make_option(c("-i", "--input"), type = "character",
              help = "Output of mtc.R", metavar = "character"),
  make_option(c("-o", "--output"), type="character",
              metavar = "character", help = "Output pdf file [default %default]")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

if (is.null(opt$input) || is.null(opt$output)){
  print_help(opt_parser) 
  stop("Arguments 'input' and 'output' are required\n", call. = FALSE)
}

## Run
set.seed(123)
tb <- read.table(opt$input, header = F)

pdf(opt$output, paper = 'a4r')

hist(tb[, 1], main = "", xlab = sprintf("Data in '%s'", opt$input))

off <- dev.off()
