#' Generate an output data set selecting only the columns of a language and the other 
#' needed to import data from a language in Anki
#'
#' @param in_dat main_data set containing all the languages
#' @param out_dat data_set to be generated with the function
#' @param language language to be filtered
#' @param help_column string (or vector of strings) indicating the names of the additional
#' columns to be included in the output data set
#'
#' @return Create a CSV file
#' @export
#'
#' @examples
#' 
generate_output <- function(in_dat, out_dat, language, help_language = c()) {
  # read input data and filter
  dat <- suppressMessages(readr::read_csv2(in_dat))
  # include the help language column (optional)
  if (length(help_language) > 0) {
    dat <- dplyr::select(dat, word, image_html, tidyselect::starts_with(language), 
                         tidyselect::all_of(help_language))
  } else {
    dat <- dplyr::select(dat, word, image_html, tidyselect::starts_with(language))
  }
  # remove audio column (no html) if present
  i <- vapply(dat, function(x) !all(startsWith(x, "vocab-")), logical(1))
  dat <- dat[,i]
  # modify the first column to create the first field used in Anki
  dat$word <- paste0(dat$word, " - ", language)
  dat <- dplyr::rename(dat, first_field = word)
  readr::write_excel_csv2(dat, out_dat)
}
