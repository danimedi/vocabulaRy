#' Update the data set and the directory system of `new_data`
#' 
#' Updating the directory system is optional and it's set to `FALSE` by default. With the 
#' new system of including new words there is no need to update the directory system.
#'
#' @param new_data_media path to the directory with the media files of the new words
#' @param new_data_set path to the data set with the new words
#' @param main_data_media path to the directory with the main media files
#' @param main_data_set path to the main data set of the words
#'
#' @return
#' @export
#'
#' @examples

update_new_data <- function(
  new_data_media, 
  new_data_set, 
  main_data_media = "", 
  main_data_set = "",
  update_dirs = FALSE
) {
  
  if (update_dirs) {
    # obtain the information for directories
    new_dirs <- list.dirs(here::here(new_data_media), full.names = FALSE)
    main_dirs <- list.dirs(here::here(main_data_media), full.names = FALSE)
    # deal with non-existing directories
    for (dir in main_dirs[!main_dirs %in% new_dirs]) {
      dir.create(here::here(new_data_media, dir))
    }
    # # MAYBE REMOVING THINGS IN THIS FUNCTION IS NOT A GOOD IDEA :(
    # # deal with leftover directories
    # for (dir in new_dirs[!new_dirs %in% main_dirs]) {
    #   unlink(here::here(new_data_media, dir), recursive = TRUE)
    # }
  }
  
  # read data sets
  dat_new <- suppressMessages(readr::read_csv2(here::here(new_data_set)))
  dat_main <- suppressMessages(readr::read_csv2(here::here(main_data_set)))
  # update the columns of the data set
  dat_empty <- dat_main[FALSE, ]
  dat_new <- dplyr::bind_rows(dat_empty, dat_new)
  readr::write_excel_csv2(dat_new, here::here(new_data_set))
  
}
