#' Generate a small data set with the values of `language`, `language_code` and `audio_path`
#'
#' This information is important to download and check the audio files easily using loops.
#'
audio_language_and_path <- function() {
  path_audio <- function(dir) file.path("data-raw/media/audios", dir)
  tibble::tribble(
    ~language, ~language_code, ~audio_path,
    "english", "en", path_audio("english_forvo"),
    "spanish", "es", path_audio("spanish_forvo"),
    "portuguese", "pt", path_audio("portuguese_forvo"),
    "french", "fr", path_audio("french_forvo"),
    "chinese", "zh", path_audio("chinese_forvo"),
    "cantonese", "yue", path_audio("cantonese_forvo"),
    "hindi", "hi", path_audio("hindi_forvo"),
    "arabic", "ar", path_audio("arabic_forvo"),
    "russian", "ru", path_audio("russian_forvo"),
    "bengali", "bn", path_audio("bengali_forvo"),
    "japanese", "ja", path_audio("japanese_forvo")
  )
}
