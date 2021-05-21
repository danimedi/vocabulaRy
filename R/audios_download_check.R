#' Download audios for the words in the data set and check missing or unused audios
#'
#' 1. Download audios and store them in the appropriate directory.
#' 2. Create a text file with the missing audios.
#' 3. Remove unused audios.
#' The function `download_audios_all()` loops over all the available languages in
#' [audio_language_and_path()].
#'
audios_download_check <- function(language) {
  i <- audio_language_and_path()$language == language
  lookup <- audio_language_and_path()[i, ]
  dat <- data_set()
  tts_forvo(dat[[language]], lookup$language_code, lookup$language, lookup$audio_path)
  # Recognize the file with the words with missing audios to add or remove the downloaded words.
  # Compare the downloaded audios in the medial directory with the audios in the data set.
  audio_data <- paste0(dat[[language]], ".mp3")
  audio_files <- list_files2(lookup$audio_path, pattern = "[.]mp3$", full_names = FALSE)
  missing <- setdiff(audio_data, audio_files)
  writeLines(missing, file.path(lookup$audio_path, "missing_audios.txt"), useBytes = TRUE)
  # Remove audios that are not present in the data set
  unused <- setdiff(audio_files, audio_data)
  file.remove(file.path(lookup$audio_path, unused))
}

# Loop for the function
audios_download_check_all <- function() {
  purrr::walk(audio_language_and_path()$language, audios_download_check)
}
