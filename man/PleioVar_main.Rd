% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PleioVar_main.R
\name{PleioVar_main}
\alias{PleioVar_main}
\title{Main pipeline of PleioVar}
\usage{
PleioVar_main(
  ListofTraits,
  ParametersTable,
  Index,
  sourceGWAS = getwd(),
  NbCores = 1,
  gzip = F,
  pU = 1e-05,
  ThreshSelectionPvalues = 5e-08/length(ListofTraits),
  keepIntermediateFiles = F,
  Minimum_MAF = 0.05
)
}
\arguments{
\item{ListofTraits}{The list of traits to be processed by PleioVar}

\item{ParametersTable}{The parameters table for each pair of traits, obtained
from LHC-MR}

\item{Index}{A dataframe with 2 columns, that contain respectively the name of
the variants and their LDscores.}

\item{sourceGWAS}{The folder where GWAS summary statistics files are held.}

\item{NbCores}{The number of cores to use, passed to `mclapply()`. Greatly
reduces the computation time.}

\item{gzip}{TRUE if you want the example data to be gzipped, FALSE otherwise.
gzip= F will speed up computations, but will increase disk space usage (only
relevant if keepIntermediateFiles = TRUE).}

\item{pU}{Polygenicity of the confounder U, as this parameter is not obtained
from LHC-MR. 1e-05 is a robust value, we do not advise to change it.}

\item{ThreshSelectionPvalues}{P-value threshold to select PleioVar top variants, if you do not want
the default Bonferroni correction.}

\item{keepIntermediateFiles}{TRUE if you want to keep the intermediates files,
which can take a lot of disk space with a high number of traits and genetic variants.
We advise to set gzip = T in this case. FALSE if you want to remove them.}

\item{Minimum_MAF}{Genetic variants with minimum allele frequency below this value will be filtered out.}
}
\description{
`PleioVar_main()` is the main function of PleioVar, that takes as input the list of traits to process,
the LDscore index, and the LHC-MR parameters table.

It will write in the Results/ folder, for each trait, the pleiotropic label
of all variants.
}
