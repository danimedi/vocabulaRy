# library(targets)
# 
# tar_option_set(packages = "readr", "here", "dplyr", "httr", "rvest", "stringr")
# 
# sapply(list.files("code", full.names = TRUE, pattern = "[.]R$"), source)
# 
# list()

# FOR THE MOMENT HERE ARE SOME WORKFLOWS

sapply(list.files("code", full.names = TRUE, pattern = "[.]R$"), source)

# check data --------------------------------------------------------------

check_data(data_set = "data/data_set.csv", image_folder = "data/media/images")


# download and check audios -----------------------------------------------

# download audio files from the words
text_to_speech()
# check that the all the files are downloaded and referenced in the data set
check_downloaded_audios()
# generate mini data set to be included in the main data set with the names
# of the audio files
create_audio_columns()



# check and incorporate new data ------------------------------------------

check_new_data()
# incorporate_new_data() # be careful!
