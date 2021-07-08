library(plumber)
library(ggplot2)

#' @title send_message
#' @description sends a message
#' @param msg The message to send
#' @export
#' @return \code{list} containing message
#' @get /echo
send_message <- function(msg="Test") {
    list(message1 = paste0("The message is: ", msg), message2 = "test")
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
