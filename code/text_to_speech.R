#' Download audio files from text using the Sound of Text API
#' 
#' Text to speech function to download MP3 files using an API of Sound of Text
#' https://soundoftext.com/
#'
#' @param words string or vector of strings
#' @param voice voice for generating audio files, check https://soundoftext.com/docs#voices
#' @param folder_path path of the folder that will contain the MP3 files of the words
#' @param sleep_time time to sleep between downloading each word
#'
#' @return
#' @export
#'
#' @examples
#' text_to_speech(c("hello", "world"), "en-US")

text_to_speech <- function(
  words, 
  voice,
  folder_path = choose.dir(caption = "Select folder where audio files will be saved"),
  sleep_time = 2
) {
  # API web page
  API <- "https://api.soundoftext.com/"
  # loop to obtain the audios and download them
  for (word in words) {
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
    download.file(url, paste0(folder_path, "/", word, ".mp3"), mode = "wb")
  }
}
