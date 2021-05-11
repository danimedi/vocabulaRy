#' Load the data set
data_set <- function() {
  suppressMessages(readr::read_csv2("data-raw/data_set.csv"))
}
