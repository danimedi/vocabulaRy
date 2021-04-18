#' Generate a data set from the images in the new data
#'
#' @param path_new_data 
#' @param path_main_data_set 
#'
#' @return
#' @export
#'
#' @examples
#' 
generate_new_data_set <- function(path_new_data, path_main_data_set) {
  
  # read and empty the main data set
  dat <- readr::read_csv2(path_main_data_set)
  dat <- dat[FALSE, ]
  
  # names of the images
  imgs <- list.files(path_new_data, pattern = "[.]jpg$")
  # extract names
  if (!all(grepl("[.]jpg$", imgs))) return("There are files that are not JPG")
  words <- gsub("[.]jpg$", "", imgs)
  
  # create new names and change the names of the images
  new_imgs <- paste0("vocab-", imgs)
  from <- list.files(path_new_data, full.names = TRUE, pattern = "[.]jpg$")
  to <- file.path(dirname(from), new_imgs)
  file.rename(from, to)
  
  # include the new words to the data set
  dat <- dplyr::bind_rows(dat, tibble::tibble(word = words))
  # create new columns
  dat$image <- new_imgs
  dat$image_html <- paste0("<img src=\"", dat$image, "\">")
  # and write the data set
  readr::write_excel_csv2(dat, file.path(path_new_data, "data_set.csv"))
  
}
