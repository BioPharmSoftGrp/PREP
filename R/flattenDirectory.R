#' Flatten a directory
#'
#' All files are copied from inDir to outDir. Nested directories are removed. For example, `src/module/home.R` becomes `R/module_home.R`
#' 
#' @param inDir a directory to flatten from
#' @param ourDir a directory to flatten to
#' @param overwrite overwrite files in outDir? 
#' 
#' @importFrom purrr map_chr
#'
#' @return list of filenames added to outDir

flattenDirectory<-function(inDir="src", outDir="R", overwrite=TRUE){
    outFiles <-  map_chr(
        list.files(inDir, recursive=TRUE),
        ~flattenFile(
            path=.x,
            inDir=inDir, 
            outDir=outDir, 
            overwrite=overwrite)
        )
    return(outFiles)
}