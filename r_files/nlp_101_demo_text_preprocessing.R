# install.packages("readr")
# install.packages("dplyr")
# install.packages("stringr")
# install.packages("tidytext")
# install.packages("SnowballC")

library(readr)
library(dplyr)
library(stringr)
library(tidytext)
library(SnowballC)

nyc <- read_csv("r_nyc_10k.csv")

## 1.) Character Encoding
guess_encoding(nyc$head)

head(nyc)

## 2.) String Manipulation
nyc$body <- str_remove_all(nyc$body, "&amp")

nyc$body <- str_remove_all(nyc$body, '[:punct:]')

nyc$body <- str_to_lower(nyc$body)

nyc$body <- str_replace_all(nyc$body, "New York", "New_York")

## 3.) Tokenization
tokens <- nyc %>%
  unnest_tokens("word", body)

## 4.) Stopword Removal
data(stop_words)

tokens <- tokens %>%
  anti_join(stop_words)   

## 5.) Stemming
stems <- tokens %>%
  mutate(stem = wordStem(word))

head(stems)

## 6.) Parts-of-Speech (POS) Tags

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
