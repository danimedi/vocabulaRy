#' Transform to lower case the necessary columns in the data set of languages
#'
#' @param dat data set
#'
#' @return Another data set with the same dimensions, but with lower case in the adequate 
#' columns
#' @export
#'
#' @examples
#' 
columns_to_lower_case <- function(dat) {
  for (i in seq_along(dat)) {
    if (i >= 5) {
      dat[[i]] <- tolower(dat[[i]])
    }
  }
  dat
}
