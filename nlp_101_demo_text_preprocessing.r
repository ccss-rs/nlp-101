library(readr)
library(dplyr)
library(stringr)
library(tidytext)
library(SnowballC)

nyc <- read_csv("nyc_10k.csv")

nyc 

nyc$body <- str_remove_all(nyc$body, "\n")

nyc$body <- str_remove_all(nyc$body, '[:punct:]')

nyc$body <- str_to_lower(nyc$body)

nyc$body <- str_replace_all(nyc$body, "New York", "New_York")

tokens <- nyc %>%
    unnest_tokens("word", body)

data(stop_words)
    
tokens <- tokens %>%
  anti_join(stop_words)   

stems <- tokens %>%
  mutate(stem = wordStem(word)) %>%
  count(stem, sort = TRUE)

library("udpipe")

## Donwload & load the POS tags for English
model <- udpipe_download_model(language = "english")
model <- udpipe_load_model(model)

## Annotation will take quite some time, particularly if you're using the 
## non-stopword version of our tokenized dataset 
tags <- udpipe_annotate(model, x = tokens$word)

## The generated "upos" column in the following dataframe will have each token's 
## identified POS tags.
pos <- as.data.frame(tags)

install.packages("readr")
install.packages("dplyr")
install.packages("stringr")
install.packages("tidytext")
install.packages("SnowballC")
install.packages("learnr")


