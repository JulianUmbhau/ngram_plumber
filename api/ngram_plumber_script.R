library(plumber)
library(textcat)

#' @apiTitle ngram + mtcars API
#' @apiDescription prints output of ngram textcat and plots mtcars cylinders

#' Print to log
#' @filter logger
logger <- function(req){
  
  cat("\n", as.character(Sys.time()), 
      "\n", req$REQUEST_METHOD, req$PATH_INFO, 
      "\n", req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR)
  
  plumber::forward()
}

#' @param txt A string value, the text to categorise.
#' @get /textcat
#' @description Perform language categorisation
guessLanguage <- function(txt, method="default") {
  
  input <- txt

  output <- textcat(txt)
  
  cat(
    "\n   Input: ", input,
    "\n   Most likely: ", output,
    "\n   Method: ", method
  )
  
  return(output)
  
}

#' @title plot_data()
#' @description creates plot, filtering on number of cylinders
#' @param cylinders numeric, filters other cylinder numbers out
#' @import ggplot2
#' @export
#' @return \code{plot} with mtcars filtered for \code{cylinder}
#' @get /plot
#' @serializer html
plot_data <- function(cylinders) {
    data <- mtcars
    title <- "All cylinders"

    if(!missing(cylinders)) {
        title <- paste0(cylinders, " cylinders")
        data <- data[data$cyl %in% cylinders,]
    }

    #ggplot(data = data, aes(cyl, wt)) +
    #geom_point()
    plot(x = data$cyl, y = data$wt, main = title, ylab="weight", xlab="cylinders")
}