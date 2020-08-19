#' @name CreateBaSSShinyAppAsPkg2
#' @title CreateBaSSShinyAppAsPkg2
#' @description { This function creates a Shiny app as an R Package.  }
#' @export
CreateBaSSShinyAppAsPkg2 <- function(
    strProjectDirectory=getwd(),
    strShinyAppName="newApp",
    strShinyAppDisplayName="",
    #strCalculationLibraryName,
    strAuthors="",
    bCreateProjectSubdirectory = TRUE,
    modules = c("home")
){

    #### 0 - Parameter checks  ####
    if(strShinyAppDisplayName=="") strShinyAppDisplayName <- strShinyAppName
    #if(!Provided( strCalculationLibraryName))    strCalculationLibraryName <- ""

    #### 1 - Clone package directorty ####
    strProjectDirectory <- gsub( "\\\\", "/", strProjectDirectory )
    strTemplateDirectory <- paste( GetTemplateDirectory(), "/RShinyAppAsPkg2", sep="" )
    strDestDirectory <- CreateProjectDirectory(
        strProjectDirectory,
        strShinyAppName,
        bCreateProjectSubdirectory
    )
    CopyFiles(strTemplateDirectory, strDestDirectory)

    #rename the .rproj file
    strRProjName  <- paste(strDestDirectory, "/RShinyAppAsPkg2.Rproj", sep="")
    strNewRProjName <- paste(strDestDirectory,"/",strShinyAppName,".Rproj",sep ="")
    file.rename( strRProjName, strNewRProjName )

    #### 2 - Apply Whisker Templates ####
    tags <- list(
        AUTHOR_NAME=strAuthors,
        PACKAGE_NAME=strShinyAppName,
        PROJECT_NAME=strShinyAppDisplayName
    )

    vFileType <- c("\\.Rmd$", "\\DESCRIPTION$", "\\.html$") # apply template to these file types
    vFileNames <- c()
    for(i in 1:length(vFileType)){
        newFiles <- list.files(
            strDestDirectory,
            pattern = vFileType[i],
            recursive = TRUE,
            full.names = TRUE
        )
        vFileNames<-c(vFileNames,newFiles)
    }

    if (length(vFileNames) > 0){
        for(i in 1:length(vFileNames)){
            strInput <- readLines( vFileNames[i] )
            strRet  <- whisker.render(strInput, tags)
            writeLines( strRet, con = vFileNames[i] )
        }
    }

    #### 3 - Customize module selection ####
    # Coming soon

    return( "Built the app!!" ) # Reimplement text summary of updates
}


