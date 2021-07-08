library(plumber)
p = plumb(file = "ngram_plumber_script.R", dir = "api")
p$run(port = 8000)