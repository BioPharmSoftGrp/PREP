#' Flatten a file
#'
#' Renames and copies a file removing all directories in `path`.
#' 
#' @param path location of file to flatten
#' @param outDir a directory to flatten to
#' @param copy should the file be copied?
#' @param overwrite overwrite existing files? 
#' 
#' @examples
#' # flattenPath("module/test1.R")
#' # copies src/module/test1.R to R/module_test1.R 
#' 
#' @return list of filenames added to outDir

flattenFile<-function(path, inDir="src", outDir="R", copy=TRUE, overwrite=TRUE){
    split_path <- function(x) if (dirname(x)==x) x else c(basename(x),split_path(dirname(x)))    # https://stackoverflow.com/questions/29214932/split-a-file-path-into-folder-names-vector
    vPath <- split_path(path)
    flatFile<-paste(rev(vPath)[-1], collapse="_")
    flatPath<-paste(outDir, flatFile, sep="/")
    if(copy) file.copy(from=paste0("./",inDir,"/",path), to=paste0("./",flatPath))
    return(flatPath)
}