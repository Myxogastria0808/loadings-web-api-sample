library(plumber)

path <- paste0(getwd(), "/", "plumber.R")
plumber::plumb(path)$run(host = "0.0.0.0", port = 7860)
