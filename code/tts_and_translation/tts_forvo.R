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
  
  # loop to download the words
  for (word in words) {
    # name of the file
    file <- paste0("vocab-", language, "-", word, ".mp3")
    # check that the file does not exist already
    if (!file %in% list.files(output_dir)) {
      try({
        
        # create a list with the arguments/parameters
        req <- list(
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
        i <- vapply(req, function(x) nchar(x) > 0, logical(1))
        req <- req[i]
        # put the names between the arguments to create the URL
        for (i in seq_along(req)) {
          # change the order
          req[[i]][2] <- req[[i]][1]
          req[[i]][1] <- names(req[i])
        }
        req <- paste0(unlist(req), collapse = "/")
        # add the beginning of the URL
        req <- paste0(API, "/", req)
        
        # read the response with JSON
        res <- rjson::fromJSON(file = req)
        # extract the path to the MP3 file from the first element in the list
        audio_html <- res$items[[1]]$pathmp3
        # download the file
        download.file(audio_html, paste0(output_dir, "/", file), mode = "wb")
      })
    }
  }
}
