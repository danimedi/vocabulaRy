
# Improved version of `list.files` to handle some characters
list_files2 <- function(path, pattern = NULL, full_names = TRUE) {
  result <- as.character(fs::dir_ls(path))
  if (!is.null(pattern)) {
    i <- grepl(pattern, basename(path))
    result <- result[i]
  }
  if (!full_names) {
    result <- basename(result)
  }
  result
}
