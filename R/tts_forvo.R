#' Download audios from the Forvo API
#'
#' Download the audios of the words using Forvo API. The information about most of
#' the arguments comes from the API itself, and all those arguments must be *strings*,
#' if you don't want to use an optional argument leave it empty (`""`).
#'
#' @param words vector of strings with the words to download as audios
#' @param language_code language code of the audios, check https://forvo.com/languages-codes/
#' @param language name of the language, used to generate the names of the audio files,
#' e.g. "french"
#' @param output_dir directory where the audios will be saved
#' @param sex "m" for male, "f" for female
#' @param country
#' @param order
#' @param group_in_languages
#' @param username
#' @param rate
#' @param limit
#' @param key
#' @param action
#' @param format
#'
#' @return
#' @export
#'
#' @examples
#' tts_forvo("bonjour", "fr", "french", "C:/Users/NAPO/Downloads")
#'
tts_forvo <- function(
  words,
  language_code,
  language,
  output_dir,
  sex = "",
  country = "",
  order = "rate-desc",
  group_in_languages = "false",
  username = "",
  rate = "",
  limit = "",
  key = "d743942e785bf673c4c64e0a6da0ebf5",
  action = "word-pronunciations",
  format = "json"
) {

  # url of the API
  API <- "https://apifree.forvo.com"

  # remove the NAs from the words
  words <- words[!is.na(words)]
  # count errors
  errors <- 0
  # loop to download the words and return a vector with downloaded files
  downloaded <- rep(NA, length(words))
  names(downloaded) <- words
  for (word in words) {
    # name of the file
    file <- paste0(word, ".mp3")
    # check that the file does not exist already
    if (!file %in% basename(fs::dir_ls(output_dir))) {
      # transform the word to be accepted as URL
      word <- URLencode(enc2utf8(word), reserved = TRUE)

      # create a character vector with the arguments/parameters
      req <- c(
        "key" = key,
        "format" = format,
        "action" = action,
        "word" = word,
        "language" = language_code,
        "sex" = sex,
        "country" = country,
        "order" = order,
        "group-in-languages" = group_in_languages,
        "username" = username,
        "rate" = rate,
        "limit" = limit
      )
      # don't include the empty arguments/parameters
      req <- req[nchar(req) > 0]
      # put the names between the arguments to create the URL
      req <- paste0(
        vapply(
          seq_along(req),
          function(i) paste0(names(req)[[i]], "/", unname(req)[[i]]),
          character(1)
        ),
        collapse = "/"
      )
      # add the beginning of the URL
      req <- paste0(API, "/", req)

      # obtain the response from the API and count the errors
      tryCatch({
        res <- rjson::fromJSON(file = req)
        errors <- 0

        # check that the field is not empty
        if (length(res$items) > 0) {
          # extract the path to the MP3 file from the first element in the list
          audio_html <- res$items[[1]]$pathmp3
          # download and rename the file (problems with encoding)
          temp_file <- file.path(output_dir, paste0(word, ".mp3"))
          download.file(audio_html, temp_file, mode = "wb")
          file.rename(temp_file, file.path(output_dir, file))
          downloaded[word] <- TRUE
        } else {
          downloaded[word] <- FALSE
        }
      },
      # handle errors and warnings
      error = function(cnd) {
        errors <<- errors + 1
        warning(cnd)
      }
      )
      if (!errors < 5) break
    }
  }
  # NAs represent those words that already exist, so they were not downloaded
  downloaded[!is.na(downloaded)]
}
