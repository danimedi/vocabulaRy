#' Check the audio files from a list of words
#'
#' @param data data set with the data
#' @param language 
#' @param audio_dir path to the directory of the audio files
#'
#' @return A list with 2 elements indicating the problems, if any, between the data set and
#' the audio files.
#' @export
#'
#' @examples

check_audios <- function(data, language, audio_dir) {
  # select the audio columns for the language
  name_cols <- c(paste0(language, "_audio"), paste0(language, "_audio_html"))
  dat <- dplyr::select(data, tidyselect::all_of(name_cols))
  # obtain the names of the downloaded audio files
  audios <- list.files(here::here(audio_dir), pattern = "[.]mp3$")
  # create a list of the results
  list(
    names_that_do_not_coincide = dat[!dat[[2]] == paste0("[sound:", dat[[1]], "]"), ],
    words_without_audios = dat[[1]][!dat[[1]] %in% audios],
    audios_without_words = audios[!audios %in% dat[[1]]]
  )
}
