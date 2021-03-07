#' Check the audio files from a list of words
#'
#' @param words vector of strings containing the words
#' @param audio_folder folder containing the audio files
#'
#' @return A list with 2 elements indicating the problems, if any, between the data set and
#' the audio files.
#' @export
#'
#' @examples

check_downloaded_audios <- function(words, audio_folder) {
  audios <- list.files(here::here(audio_folder), pattern = "[.]mp3$")
  words <- paste0(words, ".mp3")
  list(
    words_without_audios = words[!words %in% audios],
    audios_without_words = audios[!audios %in% words]
  )
}
