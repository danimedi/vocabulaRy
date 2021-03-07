#' Create columns for the images from words to be included in the data set
#'
#' @param words vector of strings containing the first column `word` of the data set
#'
#' @return A tibble of 2 columns with names for the images to be included in the data set
#' @export
#'
#' @examples

create_image_columns <- function(words) {
  df <- tibble::tibble(
    image = paste0("vocab-", words, ".jpg"),
    image_html = paste0("<img src=\"", paste0("vocab-", words, ".jpg"), "\">")
  )
  df
}
