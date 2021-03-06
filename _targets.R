# library(targets)
# 
# tar_option_set(packages = "readr", "here", "dplyr", "httr", "rvest")
# 
# sapply(list.files("code"), source)
# 
# list()

# FOR THE MOMENT HERE ARE SOME WORKFLOWS

sapply(list.files("code"), source)

# check data --------------------------------------------------------------

check_data()


# download and check audios -----------------------------------------------

text_to_speech()
check_downloaded_audios()


# check and incorporate input ---------------------------------------------

check_input()
incorporate_input() # be careful!
