################################################################################ .
# Description:
################################################################################ .
{{TAB_NAME}}Server <- function( )
{
    #The strID here must match what is in the UI file.
    strID     <- "TabWithSubItem"
    retModule <- function( input, output, session ){



    }

    {{ADD_CALLS_TO_SERVER_TABS}}
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
