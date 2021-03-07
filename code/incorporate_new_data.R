#' Transfer the information from the new data folder to the main data set and media
#' 
#' This will update the main `data` file to contain the information stored in the new data folder, 
#' this is *will change different things* (e.g. moving images, replacing files, emptying files, 
#' etc.) so **be careful**. Preferably, **commit before running the function**.
#'
#' @param new_data_set data set containing the new words
#' @param final_data_set destination data set, with the complete information of the words
#' @param backup_folder path to the backup folder that will contain a copy of the complete
#' CSV file, before the replacement
#' @param new_media media folder containing the images of the new words
#' @param final_media destination folder for the images
#'
#' @return
#' @export
#'
#' @examples

incorporate_new_data <- function(
  new_data_set,
  final_data_set,
  backup_folder,
  new_media,
  final_media
) {
  
  # read all the folders and files
  input <- readr::read_csv2(here::here(new_data_set))
  final <- readr::read_csv2(here::here(final_data_set))
  imgs_input <- list.files(here::here(new_media))
  imgs_output <- list.files(here::here(final_media))
  
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
    here::here(final_data_set), 
    here::here(backup_folder, paste0(Sys.Date(), ".csv"))
  )
  # replace the final data set,
  readr::write_excel_csv2(res_dat, here::here(final_data_set))
  # empty the previous data set,
  readr::write_excel_csv2(res_dat[FALSE, ], here::here(new_data_set))
  # and move the images
  file.copy(list.files(here::here(new_media), full.names = TRUE), 
            here::here(final_media),
            overwrite = TRUE)
  file.remove(list.files(here::here(new_media), full.names = TRUE))
  
}
