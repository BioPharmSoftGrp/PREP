################################################################################ .
# Description:
################################################################################ .
_TAB_NAME_Server <- function( )
{
    #The strID here must match what is in the UI file.
    strID     <- "TabWithSubItem"
    retModule <- function( input, output, session ){



    }

    _ADD_CALLS_TO_SERVER_TABS_
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
