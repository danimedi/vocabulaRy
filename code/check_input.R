#' Check the input data set and media to find errors
#' 
#' Check the media and the data set in the input file and compare some things with the 
#' complete data.
#'
#' @param input_dat data set that contains the input information (input folder)
#' @param final_dat data set that contains the complete information (data folder)
#' @param image_folder folder within the input folder that contains the images / media
#'
#' @return A list with different results showing TRUE if everything is ok or FALSE if there
#' is an error.
#' @export
#'
#' @examples

check_input <- function(
  input_dat = "input/data_set.csv", 
  final_dat = "data/data_set.csv",
  image_folder = "input/media"
) {
  input <- suppressMessages(readr::read_csv2(here::here(input_dat)))
  final <- suppressMessages(readr::read_csv2(here::here(final_dat)))
  imgs <- list.files(here::here(image_folder))
  list(
    n_columns = ncol(input) == ncol(final),
    image_cols = all(paste0("<img src=\"", input$image, "\">") == input$image_html),
    n_images = length(input$image) == length(imgs),
    names_images = all(input$image == imgs)
  )
}
