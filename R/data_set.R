#' Load the data set
data_set <- function() {
  suppressMessages(readr::read_csv("data-raw/data_set.csv"))
}
