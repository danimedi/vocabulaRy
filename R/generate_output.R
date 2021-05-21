#' Create output files for a language in an specified directory
#'
#' Use the main data set to generate a data set to be imported to Anki, it contains the
#' information for one language, and it generates columns with HTML format (e.g. audios and
#' images).
#'
#' @return
#' @export
generate_output <- function(language, path) {

  # Save data set -------------------------
  dat <- data_set()
  if (!any(language == names(dat))) {
    stop("The language is not available")
  }
  # Generate the output data set ready to be imported in Anki
  output_data <- tibble::tibble(
    first_field = paste0(dat$word, " - ", language),
    word = dat[[language]],
    image_html = paste0("<img src=\"vocab-", dat$word, ".jpg\">"),
    audio_html = paste0("[sound:vocab-", language, "-", dat[[language]], ".mp3]")
  )
  # Some languages need a column with romanization of the words
  if (language == "chinese") {
    output_data$pinyin <- dat$pinyin
  }
  if (language == "cantonese") {
    output_data$jyutping <- dat$jyutping
  }
  readr::write_csv(output_data, file.path(path, paste0("data_set-", language, ".csv")))

  # Save images ------------------------
  dir.create(file.path(path, "media"))
  images <- list_files2("data-raw/media/images", pattern = "[.]jpg$")
  images_new <- file.path(path, "media", paste0("vocab-", basename(images)))
  file.copy(images, images_new, overwrite = TRUE)

  # Save audios ------------------------
  lookup <- audio_language_and_path()
  audio_path <- lookup[lookup$language == language, "audio_path", drop = TRUE]
  audios <- list_files2(audio_path, pattern = "[.]mp3$")
  audios_new <- file.path(path, "media", paste0("vocab-", language, "-", basename(audios)))
  file.copy(audios, audios_new, overwrite = TRUE)

}
