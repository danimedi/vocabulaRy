#' Download audio files from text using the Sound of Text API
#' 
#' Text to speech function to download MP3 files using an API of Sound of Text
#' https://soundoftext.com/
#'
#' @param words string or vector of strings
#' @param voice voice for generating audio files, check https://soundoftext.com/docs#voices
#' @param folder_path path of the folder that will contain the MP3 files of the words
#' @param language language of the words (used for naming the columns)
#' @param sleep_time time to sleep between downloading each word
#'
#' @return
#' @export
#'
#' @examples
#' tts_sound_of_text(c("hello", "world"), "en-US", "data/audios", "vocab-french-")

tts_sound_of_text <- function(
  words, 
  voice,
  folder_path,
  language,
  sleep_time = 2
) {
  # API web page
  API <- "https://api.soundoftext.com/"
  # loop to obtain the audios and download them
  for (word in words) {
    # create the name of the file using the language
    file_name <- paste0("vocab-", language, "-", word, ".mp3")
    if (!file_name %in% list.files(here::here(folder_path))) {
      try({
        # sleep
        Sys.sleep(abs(rnorm(1, sleep_time)))
        # request the word and obtain the ID of the audio
        req <- httr::POST(
          url = API,
          body = list(
            "engine" = "Google", 
            "data" = list("text" = word, "voice" = voice)
          ),
          path = "/sounds",
          encode = "json",
          config = list("Content-Type" = "application/json")
        )
        id <- httr::content(req)$id
        # get the direction of the audio from the id in the response
        res <- httr::GET(url = API, path = paste0("/sounds/", id))
        url <- httr::content(res)$location
        # download the audios
        download.file(url, here::here(folder_path, file_name), mode = "wb")
      })
    }
  }
}
