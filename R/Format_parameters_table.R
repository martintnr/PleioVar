#' Format parameters table from LHC-MR results
#' @description
#' `Format_parameters_table()` format LHC-MR results to be PleioVar-friendly.
#' It takes as input the results of the multiple loops of LHC-MR, and returns a unique table with all parameters.
#' @param resdir The folder holding LHC-MR results.
#' @param AllPairs A dataframe containing all unique pairs of traits that will be processed by PleioVar.
#' @param rhoXY Akin to cross-trait LD score regression intercept. For now, 0 is advised.
#'
#' @return A PleioVar-friendly parameters table from LHC-MR results.
#' @export
#'
#' @examples
Format_parameters_table <- function(AllPairs, resdir, rhoXY = 0){


  colnames(AllPairs) <- c("X", "Y")

  get_parameters <- function(A){

    Trait1 <- AllPairs[A,"X"]
    Trait2 <- AllPairs[A,"Y"]

    Nom = paste0(resdir,"/ResultsLHCMR_", Trait1, "_", Trait2)

    load(Nom) #res object is loaded
    rhoXY_ip <- rhoXY

    if(length(rhoXY) == nrow(AllPairs)){rhoXY_ip <- rhoXY[A] }

    params <- c(Trait1, Trait2,
                res[1,"iX"], res[1,"piX"],res[1,"h2X"],res[1,"tX"],res[1,"axy"],res[3,"axy"],res[1,"nX"],
                res[1,"iY"], res[1,"piY"],res[1,"h2Y"],res[1,"tY"],res[1,"ayx"],res[3,"ayx"],res[1,"nY"],
                rhoXY_ip)

    return(params)
  }
  tabparams <- as.data.frame(do.call(rbind, lapply(X = c(1:nrow(AllPairs)), FUN =  get_parameters)))


  colnames(tabparams) <- c("X", "Y",
                           "iX", "piX", "h2X", "tX", "axy", "pval_axy","nX",
                           "iY", "piY", "h2Y", "tY", "ayx", "pval_ayx", "nY",
                           "rhoXY")



  tabparams[,!names(tabparams) %in% c("X", "Y")] <- lapply( tabparams[,!names(tabparams) %in% c("X", "Y")], function(x) {
  as.numeric(x)})


  return(tabparams)

}


