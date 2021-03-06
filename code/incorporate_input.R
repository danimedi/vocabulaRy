#' Transfer the information from the input folder to the main data set and media
#' 
#' This will update the main `data` file to contain the information stored in the input folder, 
#' this is *will change different things* (e.g. moving images, replacing files, emptying files, 
#' etc.) so **be careful**. Preferably, **commit before running the function**.
#'
#' @param data_set_input data set of the input folder containing the new words
#' @param media_input media folder containing the images of the new words
#' @param data_set_final destination data set, with the complete information of the words
#' @param media_final destination folder for the images
#' @param backup_folder path to the backup folder that will contain a copy of the complete
#' CSV file, before the replacement
#'
#' @return
#' @export
#'
#' @examples

incorporate_input <- function(
  data_set_input = "input/data_set.csv", 
  media_input = "input/media", 
  data_set_final = "data/data_set.csv", 
  media_final = "data/media",
  backup_folder = "data/backups",
) {
  
  # read all the folders and files
  input <- readr::read_csv2(here::here(data_set_input))
  final <- readr::read_csv2(here::here(data_set_final))
  imgs_input <- list.files(here::here(media_input))
  imgs_output <- list.files(here::here(media_final))
  
  # check that every image is referenced in the input data set and vice versa
  if (!all(imgs_input %in% input$image)) {
    "There are some input images that are not referenced in the input data set"
  } else if (!all(input$image %in% imgs_input)) {
    "The input data set references some non-existing images"
  }
  
  # check for repeated words
  if (any(input$word %in% final$word)) {
    paste(
      "Repeated words:", 
      paste(input$word[input$word %in% final$word], collapse = " ")
    )
  }
  
  # check the number of rows and names of the columns, bind them, and organize them
  if ((nrow(input) == nrow(final)) & all(names(input) == names(final))) {
    res_dat <- dplyr::bind_rows(input, final)
    res_dat <- dplyr::arrange(res_dat, image)
  } else {
    "There is a problem between the columns of the input and final data sets"
  }
  
  # finally, create a backup,
  file.rename(
    here::here(data_set_final), 
    here::here(backup_folder, paste0(Sys.Date(), ".csv"))
  )
  # replace the final data set,
  readr::write_excel_csv2(res_dat, here::here(data_set_final))
  # empty the previous data set,
  readr::write_excel_csv2(res_dat[FALSE, ], here::here(data_set_input))
  # and move the images
  file.copy(list.files(here::here(media_input), full.names = TRUE), 
            here::here(media_final),
            overwrite = TRUE)
  file.remove(list.files(here::here(media_input), full.names = TRUE))
  
}
