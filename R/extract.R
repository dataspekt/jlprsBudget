#' Extract values from dataset.
#'
#' @param data Data frame with budget data.
#' @param pattern Regular expression to match.
#' @param period Years to be extracted.
#' @param scol Column name where \code{pattern} is searched for: default is \code{acc} for key in the chart of accounts, alternative is \code{desc} for account description.
#' @param cn If set, values are aggregated over \code{period}.
#' @param by Grouping variable; default is \code{mb}. 
#'
#' @return Data frame with grouping variable and extracted values (aggregated if \code{cn} is set).
#'
#' @note Arbitrary values of \code{scol} and \code{by} are ok they exist in \code{data}.
#'
#' @export

extract <- function(data, pattern, period, scol = "acc", cn = NULL, by = "mb")
{
    s <- do.call("grepl",list(pattern,data[,scol]))
    data <- subset(data,s)

    lst <- lapply(period, function(p){
        do.call("aggregate", list(formula=stats::as.formula(paste(paste0("y",p),by,sep="~")), data=data, FUN="sum"))
    })
    df <- Reduce(function(...) merge(...,all=TRUE), lst)
    
    if(is.character(cn) & length(cn)==1){
        args <- list(df[,by], apply(df[!is.element(colnames(df),by)],1,sum))
        names(args) <- c(by,cn)
        df <- do.call("data.frame", c(args, stringsAsFactors=FALSE))    
    }

    return(df)
}
