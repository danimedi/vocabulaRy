#' Download audios for the words in the data set
#'
#' This functions is used to download audios and store them in the appropriate directory.
#' It also creates a text file with the missing words (words without available audios).
#'
download_audios <- function(language, language_code, dir_media) {
  dat <- data_set()
  res <- tts_forvo(dat$japanese, language_code, language, dir_media)

  # Use the results to create a text file with the words that don't have audios
  URLdecode2 <- function(URL) {
    vapply(URL, function(x) {
      x <- URLdecode(x)
      Encoding(x) <- "UTF-8"
      x
    }, character(1), USE.NAMES = FALSE)
  }
  writeLines(URLdecode2(words), file.path(dir_media, "problems.txt"), sep = "\n\n", useBytes = TRUE)
}
