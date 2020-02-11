library(rvest)
library(tidyverse)
library(magrittr)
library(scales)
library(knitr)
library(lubridate)
library(tibble)
library(purrr)
library(dplyr)
library(ggplot2)
install.packages("stringer")


url <- "https://spotifycharts.com/regional/global/daily/"
head(url)
timevalues <- seq(as.Date("2019/01/01"), as.Date("2020/02/03"), by = "day")
head(timevalues); tail(timevalues)
View(timevalues)

concat.url <- function(x){
  full_url <- paste0(url, x)
  full_url
}


fullurl <- concat.url(timevalues)
fullurl

View(fullurl)

SpotifyScrape <- function(x){
  page <- x
  rank <- page %>% read_html() %>% html_nodes('.chart-table-position') %>% html_text() %>% as.data.frame()
  track <- page %>% read_html() %>% html_nodes('strong') %>% html_text() %>% as.data.frame()
  artist <- page %>% read_html() %>% html_nodes('.chart-table-track span') %>% html_text() %>% as.data.frame()
  streams <- page %>% read_html() %>% html_nodes('td.chart-table-streams') %>% html_text() %>% as.data.frame()
  dates <- page %>% read_html() %>% html_nodes('.responsive-select~ .responsive-select+ .responsive-select .responsive-select-value') %>% html_text() %>% as.data.frame()

  #combine, name, and make it a tibble
  chart <- cbind(rank, track, artist, streams, dates)
  names(chart) <- c("Rank", "Track", "Artist", "Streams", "Date")
  Complete <- as.tibble(chart)
}
ptm <- proc.time()
spotify <- map_df(fullurl, SpotifyScrape)
proc.time() - ptm
View(spotify)


head(spotify)
help(gsub)

View(spotify)
attach(spotify)
view(spotify)

spotifyM <- (spotify %>% mutate(Artist = gsub("by ", "", Artist))%>% 
  mutate(Streams = gsub(",", "", Streams)) %>% mutate(Streams = as.numeric(Streams))%>%
  mutate(Date = as.Date.character(Date, "%m/%d/%y")) %>%
  mutate(Track = as.character(Track)))
head(spotifyM); tail(spotifyM)

summary(spotifyM$Streams)
boxplot(spotifyM$Streams)

fivenum(spotifyM$Streams)
stem(spotifyM$Streams)
ggplot(spotifyM, aes(x=Artist, y=Streams)) + geom_point()

Rank1 <- filter(spotifyM, spotifyM$Rank == 1)
View(Rank1)

