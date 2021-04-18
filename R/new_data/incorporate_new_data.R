#' Transfer the information from the new data folder to the main data set and media
#' 
#' This will update the main `data` file to contain the information stored in the new data folder, 
#' this is *will change different things* (e.g. moving images, replacing files, emptying files, 
#' etc.) so **be careful**. Preferably, **commit before running the function**.
#'
#' @param new_data_dir 
#' @param main_data_set_path 
#' @param main_image_dir 
#' @param backup_dir 
#' @param new_data_set_path 
#'
#' @return
#' @export
#'
#' @examples

incorporate_new_data <- function(
  new_data_dir,
  main_data_set_path,
  main_image_dir,
  backup_dir,
  new_data_set_path = file.path(new_data_dir, "data_set.csv")
) {
  
  # read data sets
  input <- readr::read_csv2(file.path(new_data_set_path))
  final <- readr::read_csv2(main_data_set_path)
  
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
    main_data_set_path, 
    file.path(backup_dir, paste0(Sys.Date(), ".csv"))
  )
  # replace the final data set,
  readr::write_excel_csv2(res_dat, main_data_set_path)
  # empty the previous data set,
  readr::write_excel_csv2(res_dat[FALSE, ], new_data_set_path)
  # and move the images
  img_paths <- list.files(new_data_dir, full.names = TRUE, pattern = "[.]jpg$")
  file.rename(
    from = img_paths,
    to = file.path(main_image_dir, basename(img_paths))
  )
  
}
