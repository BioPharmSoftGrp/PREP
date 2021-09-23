#' Flatten a file
#'
#' Renames and copies a file removing all directories in `path`.
#'
#' @param strPath location of file to flatten
#' @param strInDir the directory of the file
#' @param strOutDir a directory to flatten to
#' @param bCopy should the file be copied?
#' @param bOverwrite overwrite existing files?
#'
#' @examples
#' # FlattenPath("module/test1.R")
#' # copies src/module/test1.R to R/module_test1.R
#'
#' @return list of filenames added to outDir
FlattenFile<-function(strPath, strInDir="src", strOutDir="R", bCopy = TRUE, bOverwrite=TRUE){
    split_path <- function(strPath)
    {
        if( dirname(strPath) == strPath )
        {
            strPath
        }
        else
        {
            # https://stackoverflow.com/questions/29214932/split-a-file-path-into-folder-names-vector
            c( basename(strPath), split_path(dirname(strPath)) )
        }
    }
    vPath    <- split_path(strPath)
    flatFile <- paste(rev(vPath)[-1], collapse="_")
    flatPath <- paste(strOutDir, flatFile, sep="/")
    if( bCopy   )
    {
        strFrom <- paste0("./",strInDir,"/",strPath)
        strTo   <- paste0("./",flatPath)
        file.copy( from = strFrom, to = strTo, overwrite = bOverwrite )
    }
    return(flatPath)
}
