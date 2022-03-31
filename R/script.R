# load packages ####
library(rStrava) # devtools::install_github('fawda123/rStrava')
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)
library(corrr)


# initial setup ####
# Strava key
app_name <- 'RData'
app_client_id <- '80345'
app_secret <- '8c3db80a736e1e8008f967ef58cd087631a16ef6'

# create strava token
my_token <- httr::config(token = strava_oauth(app_name, app_client_id, app_secret, app_scope="activity:read_all"))


# get my info

myinfo <- get_athlete(my_token, id = '10533584')
head(myinfo)

# creating data frame for my data

my_act <- get_activity_list(my_token)
act_df <- compile_activities(my_act, units = "metric")

# dataframe with only variable of interest

act_df_interest <- act_df %>% select(type, distance, start_date, moving_time, average_speed, average_heartrate)  

# data visualisation 2022
act_df_interest %>%
  filter(type == "Run", moving_time < 50000, distance > 1) %>%
  ggplot(aes(distance, moving_time)) +
  geom_point()


