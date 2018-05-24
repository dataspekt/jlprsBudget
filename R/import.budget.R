#' Import budget data from raw Excel file.
#'
#' @param path Path to file.
#' @param rm.sheets Sheets to remove; if NULL, all sheets are imported.
#' @param rm.cols Columns to remove.
#' @param skip Number of rows to skip.
#'
#' @details All sheets will be imported except those specified in \code{rm.sheets}. Sheet name is used as value of \code{lau.name} and first two digits of file name are used as value of \code{county.code} in the resulting data frame.
#'
#' @export

import.budget <- function(path, rm.sheets = 1:5, rm.cols = c(5,7,9), skip = 9)
{
    sheets <- readxl::excel_sheets(path)
    if(!is.null(rm.sheets))
        sheets <- sheets[-rm.sheets]
    
    lst <- lapply(sheets, function(s){
        dat <- readxl::read_excel(path,s,skip=skip,col_names=FALSE)[-rm.cols]
        dat$lau.name <- s
        dat$county.code. <- substr(regmatches(path,gregexpr("[^\\/]+$",path)),1,2)
        return(dat)
    })
    names(lst) <- sheets
    
    return(Reduce(function(...) merge(...,all=TRUE),lst))
}
