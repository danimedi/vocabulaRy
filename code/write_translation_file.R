library(readr)
library(here)

dat <- read_csv2(here("data/data_set.csv"))
filt_dat <- dat[ , c("english", "spanish")]

write_delim(filt_dat, here("data/translation_data.txt"), delim = "\t")
