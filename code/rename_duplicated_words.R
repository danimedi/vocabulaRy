library(readr)
library(here)

# read data -------
data_set <- read_csv2(here("data/raw/data_set_words.csv"), col_names = FALSE)

# frequency table -------
# generate frequency
tab_freq <- table(data_set$X2)
# obtain repeated words
dup_words <- names(tab_freq)[tab_freq > 1]

# rows with duplicated words -------
filt_dat <- data_set[data_set$X2 %in% i, ]

# change the duplicated words ---------
filt_dat$X2 # repeated
# create new words
new_words <- c(
  "back (body)", "back (direction)", 
  "clean (adjective)", "clean (verb)", 
  "fall (season)", "fall (verb)", 
  "fan (device)", "fan (person)", 
  "foot (body)", "foot (unit)", 
  "light (brightness)", "light (weight)", "light (noun)", 
  "old (things)", "old (people)", 
  "orange (fruit)", "orange (color)", 
  "race (people)", "race (competition)", 
  "second (position)", "second (time)", 
  "sex (action)", "sex (male/female)", 
  "short (distance)", "short (size)", 
  "sign (write)", "sign (indication)"
)
# replace previous with new words
words <- data_set$X2
k <- j <- 1
for (i in words) {
  if (i %in% dup_words) {
    words[k] <- new_words[j]
    j <- j + 1
  }
  k <- k + 1
}

# write text file --------
write_lines(words, here("data/clean/renamed_duplicates.txt"))
