library(here)
library(readr)
library(rvest)

english_to_spanish <- function(words) {
  res <- vector("list", length(words))
  k <- 1
  for (word in words) {
    dir1 <- paste0("https://www.linguee.com/english-spanish/search?source=english&query=", word)
    dir2 <- paste0("https://es.wiktionary.org/wiki/", word)
    web1 <- read_html(dir1)
    web2 <- read_html(dir2)
    word1 <- web1 %>% html_nodes(".dictLink") %>% .[2] %>% html_text() %>% tolower()
    word2 <- web2 %>% html_node("dd a") %>% html_text() %>% tolower()
    res[[k]] <- c(word1, word2)
    k <- k + 1
    Sys.sleep(abs(rnorm(1, 4.5, 1)))
  }
  return(res)
}
