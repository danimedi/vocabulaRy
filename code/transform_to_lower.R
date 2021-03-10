#' Translate the values of some columns to lower case
#'
#' @param data_path path to the data set
#' @param columns vector of strings with the names of the columns to be transformed
#' @param rewrite_data rewrite the read data set?
#'
#' @return
#' @export
#'
#' @examples
#' 
transform_to_lower <- function(data_path, columns, rewrite_data = TRUE) {
  # read CSV file
  dat <- suppressMessages(readr::read_csv2(here::here(data_path)))
  # transform to lower the selected columns
  for (i in seq_along(dat)) {
    if (names(dat)[i] %in% columns) {
      dat[[i]] <- tolower(dat[[i]])
    }
  }
  # rewrite data or not
  if (rewrite_data) {
    readr::write_excel_csv2(dat, here::here(data_path))
  } else {
    dat
  }
}
