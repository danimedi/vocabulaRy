#' Create columns for the audio files from words to be included in the data set
#'
#' @param words vector of strings containing the words of the language
#' @param language language of the words and audios
#'
#' @return A tibble of 2 columns with names for the audio files to be included in the data set
#' @export
#'
#' @examples
#' create_audio_columns(dat$french, "french")

create_audio_columns <- function(words, language) {
  df <- tibble::tibble(
    paste0("vocab-", language, "-", words, ".mp3"),
    paste0("[sound:", paste0("vocab-", language, "-", words, ".mp3"), "]")
  )
  names(df) <- c(paste0(language, "_audio"), paste0(language, "_audio_html"))
  df
}
