# library(targets)
# 
# tar_option_set(packages = "readr", "here", "dplyr", "httr", "rvest")
# 
# sapply(list.files("code", full.names = TRUE, pattern = "[.]R$"), source)
# 
# list()

# FOR THE MOMENT HERE ARE SOME WORKFLOWS

sapply(list.files("code", full.names = TRUE, pattern = "[.]R$"), source)

# check data --------------------------------------------------------------

check_data(data_set = "data/data_set.csv", image_folder = "data/media/images")


# download and check audios -----------------------------------------------

text_to_speech()
check_downloaded_audios()


# check and incorporate input ---------------------------------------------

check_input()
incorporate_input() # be careful!
