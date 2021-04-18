#' Generate output data set ready to be imported to Anki
#'
#' Use the main data set to generate a data set to be imported to Anki, it contains the
#' information for one language, and it generates columns with HTML format (e.g. audios and
#' images).
#'
#' @param language The language which is used to generate the data.
#' @param data The main data set.
#'
#' @return A tibble.
#' @export
#'
#' @examples
generate_output <- function(language, data = "data/data_set.csv") {
  dat <- readr::read_csv2(data)
  if (!any(language == names(dat))) {
    stop("That language is not available")
  }
  # Generate the output data set ready to be imported in Anki
  output <- tibble::tibble(
    first_field = paste0(dat$word, " - ", language),
    word = dat[[language]],
    image_html = paste0("<img src=\"vocab-", dat$word, ".jpg\">"),
    audio_html = paste0("[sound:vocab-portuguese-", dat[[language]], ".mp3]")
  )
  # Some languages need a column with romanization of the words
  if (language == "chinese") {
    output$pinyin <- dat$pinyin
  }
  if (language == "cantonese") {
    output$jyutping <- dat$jyutping
  }
  output
}
