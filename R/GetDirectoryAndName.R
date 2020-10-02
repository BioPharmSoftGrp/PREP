#################################################################################################### .
#   Program/Function Name:
#   Author: J. Kyle Wathen
#   Description: Function to split the path into the directory name (without the last folder)
#               and name which is created from the last folder.
#   Change History:
#   Last Modified Date: 10/01/2020
#################################################################################################### .
#' @name GetDirectoryAndName
#' @title GetDirectoryAndName
#' @description { Function to split the path into the directory name (without the last folder)
#'               and name which is created from the last folder.   }
GetDirectoryAndName <- function( path)
{
    lIndex             <- gregexpr( pattern="[\\]", path)
    nLastIndex         <- lIndex[[ 1 ]][ length( lIndex[[1]] ) ]
    strPath            <- substr( path, 1, nLastIndex )
    strName            <- substring( path, nLastIndex + 1 )

    lRet <- list( strPath = strPath, strName = strName)
    return( lRet )   # Use an explicit return
}
