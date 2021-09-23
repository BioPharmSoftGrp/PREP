#' Flatten a directory
#'
#' All files are copied from inDir to outDir. Nested directories are removed. For example, `src/module/home.R` becomes `R/module_home.R`
#'
#' @param strInDir a directory to flatten from
#' @param strOutDir a directory to flatten to
#' @param bOverwrite overwrite files in outDir?
#'
#' @importFrom purrr map_chr
#'
#' @return list of filenames added to outDir
#' @export
FlattenDirectory<-function(strInDir="src", strOutDir="R", bOverwrite=TRUE){
    outFiles <-  map_chr(
        list.files(strInDir, recursive=TRUE),
        ~FlattenFile(
            path=.x,
            inDir=strInDir,
            outDir=strOutDir,
            overwrite=bOverwrite)
        )
    return(outFiles)
}
