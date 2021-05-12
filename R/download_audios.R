#' Download audios for the words in the data set
#'
#' This functions is used to download audios and store them in the appropriate directory.
#' It also creates a text file with the missing words (words without available audios).
#'
download_audios <- function(language) {
  i <- audio_language_and_path()$language == language
  lookup <- audio_language_and_path()[i, ]
  dat <- data_set()
  tts_forvo(dat[[language]], lookup$language_code, lookup$language, lookup$audio_path)
  # Recognize the file with the words with missing audios to add or remove the downloaded words.
  # Compare the downloaded audios in the medial directory with the audios in the data set.
  audio_data <- paste0("vocab-", language, "-", dat[[language]], ".mp3")
  audio_files <- list_files2(lookup$audio_path, pattern = "[.]mp3$")
  missing <- setdiff(audio_data, audio_files)
  writeLines(missing, file.path(lookup$audio_path, "missing_audios.txt"), useBytes = TRUE)
  # Remove audios that are not present in the data set
  unused <- setdiff(audio_files, audio_data)
  file.remove(file.path(lookup$audio_path, unused))
}
