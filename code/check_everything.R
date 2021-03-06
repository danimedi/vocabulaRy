#' Check that different parameters are correct in the project
#' 
#' Check some things to be sure that the project does not have errors, mostly related to images.
#'
#' @param data_set path to the data set
#' @param image_folder path to the folder of the images
#'
#' @return A list with different results, everything should be TRUE if there are no problems.
#' @export
#'
#' @examples

check_everything <- function(data_set = "data/data_set.csv", image_folder = "data/media") {
  dat <- suppressMessages(readr::read_csv2(data_set))
  imgs <- list.files(image_folder)
  list(
    image_cols = all(paste0("<img src=\"", dat$image, "\">") == dat$image_html),
    n_images = length(dat$image) == length(imgs),
    names_images = all(dat$image == imgs)
  )
}
