
################################################################################ .
# Description:
################################################################################ .
HomeServer <- function( strID )
{
    retModule <- function( input, output, session ){


    }


    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}

