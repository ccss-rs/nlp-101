# install.packages("readr")
# install.packages("dplyr")
# install.packages("stringr")
# install.packages("vader")
# install.packages("ggplot2")

library(readr)
library(dplyr)
library(stringr)
library(vader)
library(ggplot2)

setwd("FILL HERE")
nyc <- read_csv("r_nyc_10k.csv")

write_csv(nyc_sentiment, "r_nyc_10k_sentiment.csv")

get_vader("As someone who always depended on cars before, I LOVE the subway! <3")

get_vader("The subway is very helpful, but I'm not a fan of the rats.")

get_vader("I hate how delayed the subway always is… being late for work sucks. :(")

# Don't actually run this- it takes a while to run 
nyc_sentiment <- vader_df(nyc$body)

nyc_sentiment <- read_csv('nyc_sentiment.csv')
nyc_sentiment

top_pos <- nyc_sentiment %>%
    top_n(5, compound)

top_pos$text

top_neg <- nyc_sentiment %>%
    top_n(-5, compound)

top_neg

nyc_full <- merge(nyc, nyc_sentiment, by.x = "body", by.y = "text")

ggplot(nyc_full[which(nyc_full$score>20),], aes(x=compound, y=score)) + geom_point()

ggplot(nyc_full[which(nyc_full$score<0),], aes(x=compound, y=score)) + geom_point()
