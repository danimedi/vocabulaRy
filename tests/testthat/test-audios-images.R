test_that("names of images coincide", {
  imgs_dat <- paste0("vocab-", data_set$word, ".jpg")
  imgs_files <- list.files("data-raw/media/images")
  expect_equal(sort(imgs_dat), sort(imgs_files))
})

test_that("names of audios coincide", {

})
