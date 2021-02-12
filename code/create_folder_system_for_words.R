library(here)
library(readr)

dir_create_tree <- function(..., output_dir = getwd()) {
  # setting the output directory as starting point
  current_dir <- getwd()
  setwd(output_dir)
  # arguments as a list
  args <- list(...)
  # all the possible combinations
  combos <- expand.grid(args)
  # loop to work with each row
  apply(combos, 1, function(row) {
    i <- 1
    path <- row[i]
    # loop to create the directories needed to complete the row from left to right
    # (you can only create directories inside another existing directory)
    for (x in row) {
      suppressWarnings(dir.create(path))
      i <- i + 1
      path <- file.path(path, row[i])
    }
  })
  setwd(current_dir)
}

# read words with renamed duplicates
words <- read_lines(here("data/clean/renamed_duplicates.txt"))


# COMPLETE THIS

# create folder system
# x1 <- words
# x2 <- c("media")
dir_create_tree()

