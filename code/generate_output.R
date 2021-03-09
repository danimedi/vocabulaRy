#' Generate an output data set selecting only the columns of a language and the other 
#' needed to import data from a language in Anki
#'
#' @param in_dat main_data set containing all the languages
#' @param out_dat data_set to be generated with the function
#' @param language language to be filtered
#'
#' @return Create a CSV file
#' @export
#'
#' @examples
#' 
generate_output <- function(in_dat, out_dat, language) {
  # read input data and filter
  dat <- suppressMessages(readr::read_csv2(in_dat))
  dat <- dplyr::select(dat, word, image_html, tidyselect::starts_with(language))
  # remove audio column (no html) if present
  i <- vapply(dat, function(x) !all(startsWith(x, "vocab-")), logical(1))
  dat <- dat[,i]
  # modify the first column to create the first field used in Anki
  dat$word <- paste0(dat$word, " - ", language)
  dat <- dplyr::rename(dat, first_field = word)
  readr::write_excel_csv2(dat, out_dat)
}

generate_output("data/data_set.csv", "data/output/french.csv", "french")
