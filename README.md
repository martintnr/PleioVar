
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PRISM

<!-- badges: start -->
<!-- badges: end -->

PRISM takes as input GWAS data and outputs pleiotropic labels for a list
of variants.

## Installation

You can install the current version of PRISM like so:

``` r
  if(!"devtools" %in% installed.packages()[, "Package"]) {
  install.packages("devtools") }

  if(!"PRISM" %in% installed.packages()[, "Package"]) {
  devtools::install_github("martintnr/PRISM") }
```

## Example

This is a basic example to obtain pleiotropic labels from GWAS summary
statistics.  
Parameters obtained from LHC-MR, LDscores of all variants, and simulated
GWAS ZScores are already included.  
You should specify the NbCores parameters if your computer can handle
parallel computations.

``` r
library(data.table)
library(dplyr)
library(stats)
library(stringr)
library(parallel)
library(matrixStats)
library(PRISM)


if(!grepl("PRISM_example", getwd(), fixed = TRUE)){
if(!file.exists("PRISM_example/")){system("mkdir PRISM_example")}
setwd("PRISM_example")}

Prepare_example_data(gzip = T)

ParametersTable <- fread("Data/ParametersTable.csv", header = T, sep = ",")
Index <- fread("Data/Index.csv", header = T, sep = ",")

ListofTraits <- unique(c(ParametersTable$X, ParametersTable$Y))

PRISM_main(ListofTraits, ParametersTable, Index , sourceGWAS = "Data/",
              NbCores = 1, gzip = F, keepIntermediateFiles = F)
```

In the Results/ folder can be found, for each trait, a file with
variants, p-values from PRISM, and pleiotropy annotation.

``` r
library(ggplot2)

Graph <- Example_graph(ListofTraits, ParametersTable, Trait = "B4")

print(Graph)
```

If you want to use PRISM on your own data, you can use this vignette:
\[<https://github.com/martintnr/PRISM/blob/main/vignettes/PRISM_vignette.md>\]
