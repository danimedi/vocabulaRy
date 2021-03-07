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
#' @param new_media folder containing the media of the new words
#' @param final_media destination folder for the media
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
  
  # read data sets
  input <- readr::read_csv2(here::here(new_data_set))
  final <- readr::read_csv2(here::here(final_data_set))
  
  # check that the files system is the same
  if (!all(list.dirs(here::here(new_media), full.names = FALSE) == 
          list.dirs(here::here(final_media), full.names = FALSE))) {
    return("There is a problem in the file system: diferent folders in the new data")
  }
  
  # check for repeated words
  if (any(input$word %in% final$word)) {
    return(paste(
      "Repeated words:", 
      paste(input$word[input$word %in% final$word], collapse = " ")
    ))
  }
  
  # check the number of rows and names of the columns, bind them, and organize them
  if ((ncol(input) == ncol(final)) & all(names(input) == names(final))) {
    res_dat <- dplyr::bind_rows(input, final)
    res_dat <- dplyr::arrange(res_dat, image)
  } else {
    return("There is a problem between the columns of the input and final data sets")
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
  # and move the media files
  file.rename(
    from = list.files(here::here(new_media), recursive = TRUE, full.names = TRUE),
    to = paste0(final_media, "/", list.files(here::here(new_media), recursive = TRUE))
  )
  
}
