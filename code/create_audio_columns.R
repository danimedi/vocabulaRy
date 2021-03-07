#' Create a data frame with 2 columns for the audio files, to be included in the
#' data set
#'
#' @param audio_files vector of strings with the names of the audio files
#'
#' @return A data frame with 2 columns, one for the names of the audio files and one
#' for the audio files transformed to HTML. The names of the column are obtained from 
#' the names of the files and they show the language.
#' @export
#'
#' @examples

create_audio_columns <- function(audio_files) {
  
  # obtain the language from the prefix of the names of the files
  lang <- gsub("vocab-", "", audio_files[1])
  lang <- gsub(".mp3", "", lang)
  lang <- strsplit(lang, "-")[[1]][1]
  
  # create data frame and name the columns
  df <- data.frame(audio_files, paste0("[sound:", audio_files, "]"))
  names(df)[1] <- paste0(lang, "_audio")
  names(df)[2] <- paste0(lang, "_audio_html")
  
  return(df)
  
}
