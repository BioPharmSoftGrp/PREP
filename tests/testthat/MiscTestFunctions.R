CleanUpAfterTest <- function( strDirectory )
{
    if( dir.exists( strDirectory ))
    {
        unlink( strDirectory, recursive = TRUE)
    }

}
