#' Update the audio columns from the data set
#' 
#' Generates the names of the audio files of the data set
#'
#' @param data 
#'
#' @return A data set of the same dimensions
#' @export
#'
#' @examples
#' 
update_audio_columns <- function(data) {
  cols <- names(data)
  for (i in seq_along(cols)) {
    if(grepl("_audio_html", cols[i])) {
      data[[i]] <- paste0("[sound:", data[[i-1]], "]")
    } else if (grepl("_audio", cols[i])) {
      lang <- names(data[i-1])
      data[[i]] <- paste0("vocab-", lang, "-", data[[i-1]])
    }
  }
  data
}
