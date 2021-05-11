test_that("images coincide", {
  dat <- readr::read_csv2(here::here("data-raw/data_set.csv"))
  imgs_dat <- paste0("vocab-", dat$word, ".jpg")
  imgs_files <- list.files(here::here("data-raw/media/images"))
  expect_setequal(imgs_dat, imgs_files)
})
