#' Download audios for the words in the data set
#'
#' This functions is used to download audios and store them in the appropriate directory.
#' It also creates a text file with the missing words (words without available audios).
#'
download_audios <- function(language, language_code, dir_media) {
  dat <- data_set()
  tts_forvo(dat[[language]], language_code, language, dir_media)
  # Recognize the file with the words with missing audios to add or remove the downloaded words.
  # Compare the downloaded audios in the medial directory with the audios in the data set.
  audio_data <- paste0("vocab-", language, "-", dat[[language]], ".mp3")
  audio_files <- list.files(dir_media)
  writeLines(setdiff(audio_data, audio_files), file.path(dir_media, "missing_audios.txt"), useBytes = TRUE)
}
