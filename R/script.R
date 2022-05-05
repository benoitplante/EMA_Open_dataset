library(tidyverse)

# Creation des dataframes - EMA2018 / EMA2019 / EMA_total

list_of_files <- list.files(path = "C:/Users/planteb/Desktop/Projet R/blogue/EMA_Open_dataset/data/raw/UT1000_ema/UT1000_fall2018",
                            recursive = TRUE,
                            pattern = "momentary_emas.csv$",
                            full.names = TRUE)

df_EMA_2018 <- readr::read_csv(list_of_files, id = "file_name")


list_of_files <- list.files(path = "C:/Users/planteb/Desktop/Projet R/blogue/EMA_Open_dataset/data/raw/UT1000_ema/UT1000_spring2019",
                            recursive = TRUE,
                            pattern = "momentary_emas.csv$",
                            full.names = TRUE)

df_EMA_2019 <- readr::read_csv(list_of_files, id = "file_name")

df_EMA_total <- rbind(df_EMA_2018, df_EMA_2019)

df_participant <- read_delim("C:/Users/planteb/Desktop/Projet R/blogue/EMA_Open_dataset/data/raw/participant.txt", delim = ",")
df_participant <- rename(df_participant, pid = beiwe_id)

df_participant_EMA <- df_participant %>% inner_join(df_EMA_total, by = "pid")

# Choisir le nombre de personne à conserver selon le nombre de notifications répondues

df_EMA_total_group <- df_EMA_total %>%
  group_by(pid) %>%
  filter(n() >= 50) %>%
  ungroup()
