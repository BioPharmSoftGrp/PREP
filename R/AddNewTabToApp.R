#################################################################################################### .
# This funciton will add a new tab to the Shiny App.    ####
#################################################################################################### .
#' @name  AddNewTabToApp
#' @title  AddNewTabToApp
#' @description { This funciton will add a new tab to the Shiny App. This function assumes that the working directory
#' is the main directory of the Shiny app created by this package.  This function creates a module file for the UI and the Server in the Modules directory
#' of the app, it alters the ShinyUI.R file to insert the calls to  modules so the tab is added to the UI. }

#' @export
AddNewTabToApp <- function( strTabName, vSubMenuItemNames = NULL, strTemplate = "ResultViewer" )
{
    vResults              <- c()
    strModuleSubdir      <- "Modules/"
    strTabNameWithSpaces <- strTabName
    strTabName           <- gsub( " ", "", strTabName, fixed = TRUE )
    strTabName           <- gsub( "/", "_", strTabName, fixed = TRUE )

    # Note - If tags have the same begining then you must put the longer tag first, like the first two items.
    vTags    <- c( "_TAB_NAME_WITH_SPACES_", "_TAB_NAME_" )
    vReplace <- c( strTabNameWithSpaces, strTabName )
    # If vSubMenuItemNames is not supplied then the default would be a tab item with no sub items and hence the resulting tab would be a single file UI and server
    # similar to Home
    if( !Provided( vSubMenuItemNames ) )  # No Sub Items on the menu.
    {
        vResults <- CreateTab( strTabName = strTabName, strTemplate = strTemplate )

        # lCopyFile1 <- CopyTemplateFile( "NoSubItemTabModuleServer.R", paste( strModuleSubdir, strTabName, "Server.R", sep = "" ) )
        # lCopyFile2 <- CopyTemplateFile( "NoSubItemTabModuleUI.R", paste( strModuleSubdir, strTabName, "UI.R", sep = "" ) )
        #
        # if( lCopyFile1$bFileCoppied )
        # {
        #     vResults <- c(vResults, paste( "Created File", lCopyFile1$strDestinationFile ) )
        #     ReplaceTagsInFile( lCopyFile1$strDestinationFile, vTags, vReplace )
        #     AddSourceCommandToGlobal( lCopyFile1$strDestinationFile )
        #
        #
        # }
        # if( lCopyFile2$bFileCoppied )
        # {
        #     vResults <- c(vResults, paste( "Created File", lCopyFile2$strDestinationFile ) )
        #     ReplaceTagsInFile( lCopyFile2$strDestinationFile, vTags, vReplace )
        #     AddSourceCommandToGlobal( lCopyFile2$strDestinationFile )
        # }

    }
    else
    {
        #This version creates a tab for each sub-tab

        vSubMenuItemNamesWOSpace    <- gsub( " ", "", vSubMenuItemNames, fixed=TRUE)

        # Step 1: Create all the subtabs ####
        nQtySubtabs     <- length( vSubMenuItemNames )

        for( iSubtab in 1:nQtySubtabs )
        {

            vResults <- c( vResults, CreateTab( vSubMenuItemNames[ iSubtab ] , strParentTabName = strTabName ) )

        }


        # Step 2: Create the main tab that will call each subtab and need to modify ####
        lCopyFile1 <- CopyTemplateFile( "SubItemTabModuleServer.R", paste( strModuleSubdir, strTabName, "Server.R", sep = "" ) )
        lCopyFile2 <- CopyTemplateFile( "SubItemTabModuleUI.R", paste( strModuleSubdir, strTabName, "UI.R", sep = "" ) )


        #Step 3- Need to add the calls to the SubIteTabModuleServer.R and server file that was just coppied.
        strSubtabUICalls            <- paste( strTabName, vSubMenuItemNamesWOSpace, c( rep( "UI( ),",nQtySubtabs-1), "UI() "), collapse ="", sep="" )
        strSubTabSideBarMenuCalls   <- paste( strTabName, vSubMenuItemNamesWOSpace, c( rep( "SideBarMenu( ),", nQtySubtabs-1), "SideBarMenu( ) "), collapse ="",sep ="")
        strSubtabServerCalls        <- paste( strTabName, vSubMenuItemNamesWOSpace, c( rep( "Server( )\n    ",nQtySubtabs-1), "Server() "), collapse ="", sep="" )

        vTmpTags                    <- c( vTags, "_ADD_CALLS_TO_UI_TABS_", "_ADD_CALLS_TO_SIDE_BAR_MENU_", "_ADD_CALLS_TO_SERVER_TABS_" )
        vTmpReplace                 <- c( vReplace, strSubtabUICalls, strSubTabSideBarMenuCalls,  strSubtabServerCalls)


        if( lCopyFile1$bFileCoppied )
        {
            vResults <- c(vResults, paste( "Created File", lCopyFile1$strDestinationFile ) )
            ReplaceTagsInFile( lCopyFile1$strDestinationFile, vTmpTags , vTmpReplace )
            AddSourceCommandToGlobal( lCopyFile1$strDestinationFile )


        }
        if( lCopyFile2$bFileCoppied )
        {
            vResults <- c(vResults, paste( "Created File", lCopyFile2$strDestinationFile ) )
            ReplaceTagsInFile( lCopyFile2$strDestinationFile, vTmpTags , vTmpReplace )
            AddSourceCommandToGlobal( lCopyFile2$strDestinationFile )
        }
    }

    #TODO - Add the version when sub items are included

    #Insert the calls to the ShinyUI file
    ## _ADD_NEW_TAB_SIDE_BAR_ ##
    vTags    <- c( "## _ADD_NEW_TAB_SIDE_BAR_ ##", "## _ADD_NEW_TAB_UI_CALL_ ##" )
    vReplace <- paste(  c( "    ","               "), c( strTabName, strTabName ), c("SideBarMenu( ),", "UI( )," ), sep="" )
    vReplace <- paste(vReplace, "\n\n", vTags,  sep ="" )
    ReplaceTagsInFile( "ShinyUI.R", vTags, vReplace )

    vServerTag   <- c("# _ADD_NEW_TAB_SERVER_ #")
    vReplace     <- paste( "    ", strTabName, "Server( )\n\n", vServerTag, sep ="" )
    ReplaceTagsInFile( "ShinyServer.R", vServerTag, vReplace )


    # Insert the source
    strRet <- paste( vResults, collapse="\n" )
    cat( strRet )
    #return( strRet )
}

AddSourceCommandToGlobal <- function( strFileName )
{

    strSourceTag   <- "# _SOURCE_ADDITIONAL_TABS_ #"
    vSourceTag     <- strSourceTag
    vReplaceSource <- paste( "source( '", strFileName, "' ) \n", strSourceTag, sep = "" )
    ReplaceTagsInFile( "Global.R", vSourceTag, vReplaceSource )

}

CreateTab <- function( strTabName, strTemplate = "ResultViewer", strParentTabName = NULL )
{
    vResults              <- c()
    strModuleSubdir      <- "Modules/"
    strTemplateSubdir    <- "Templates/"
    strTabNameWithSpaces <- strTabName
    strTabName           <- gsub( " ", "", strTabName, fixed = TRUE )
    strTabName           <- gsub( "/", "_", strTabName, fixed = TRUE )

    vTags                <- c()
    vReplace             <- c()
    bReportTemplate      <- FALSE

    if (strTemplate == "ResultViewer")
    {
        bReportTemplate <- TRUE

    } else if (strTemplate == "NoSubItemTabModule")
    {
        bReportTemplate <- FALSE

    } else
    {
        print( "Current Supported Templates:")
        print( "ResultViewer")
        print( "NoSubItemTabModule")
        stop( paste0( strTemplate, ": This template is not supported!" ))
    }

    if( !is.null( strParentTabName) )
    {
        vTags      <- c( vTags, "menuItem(" )
        vReplace   <-  c( vReplace, "menuSubItem(")
        strTabName <- paste( strParentTabName, strTabName, sep ="" )
    }

    # Note - If tags have the same begining then you must put the longer tag first, like the first two items.
    vTags    <- c( vTags, "_TAB_NAME_WITH_SPACES_", "_TAB_NAME_" )
    vReplace <- c( vReplace, strTabNameWithSpaces, strTabName )

#     lCopyFile1 <- CopyTemplateFile( "NoSubItemTabModuleServer.R", paste( strModuleSubdir, strTabName, "Server.R", sep = "" ) )
#     lCopyFile2 <- CopyTemplateFile( "NoSubItemTabModuleUI.R", paste( strModuleSubdir, strTabName, "UI.R", sep = "" ) )

    lCopyFile1 <- CopyTemplateFile( paste0( strTemplate, "Server.R" ), paste( strModuleSubdir, strTabName, "Server.R", sep = "" ) )
    lCopyFile2 <- CopyTemplateFile( paste0( strTemplate, "UI.R" ), paste( strModuleSubdir, strTabName, "UI.R", sep = "" ) )

    if (bReportTemplate)
    {
        lCopyFile3 <- CopyTemplateFile( paste0( strTemplate, "PPT.Rmd" ), paste( strTemplateSubdir, strTabName, "PPT.Rmd", sep = "" ) )
        lCopyFile4 <- CopyTemplateFile( paste0( strTemplate, "Word.Rmd" ), paste( strTemplateSubdir, strTabName, "Word.Rmd", sep = "" ) )
    }

    if( lCopyFile1$bFileCoppied )
    {
        vResults <- c(vResults, paste( "Created File", lCopyFile1$strDestinationFile ) )
        ReplaceTagsInFile( lCopyFile1$strDestinationFile, vTags, vReplace )
        AddSourceCommandToGlobal( lCopyFile1$strDestinationFile )

    }
    if( lCopyFile2$bFileCoppied )
    {
        # If this is a subtab would also need to replace the menuItem( with subMenuItem
        vResults <- c(vResults, paste( "Created File", lCopyFile2$strDestinationFile ) )
        ReplaceTagsInFile( lCopyFile2$strDestinationFile, vTags, vReplace )
        AddSourceCommandToGlobal( lCopyFile2$strDestinationFile )
    }

    if (bReportTemplate)
    {
        if( lCopyFile3$bFileCoppied )
        {
            # If this is a subtab would also need to replace the menuItem( with subMenuItem
            vResults <- c(vResults, paste( "Created File", lCopyFile3$strDestinationFile ) )
        }

        if( lCopyFile4$bFileCoppied )
        {
            # If this is a subtab would also need to replace the menuItem( with subMenuItem
            vResults <- c(vResults, paste( "Created File", lCopyFile4$strDestinationFile ) )
        }
    }

    return( vResults )
}
