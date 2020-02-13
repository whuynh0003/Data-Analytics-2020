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
library(timelineR)


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

spotify %>% transmute(Date = gsub("/","-", Date)) %>% transmute(Date = as.Date(Date, "%mm/%dd/Y"))

head(spotify$Date); tail(spotify$Date)


Date <- as.Date(spotify$Date, "%m/%d/%Y")




spotifyM <- (spotify %>% mutate(Artist = gsub("by ", "", Artist))%>% 
  mutate(Streams = gsub(",", "", Streams)) %>% mutate(Streams = as.numeric(Streams))%>%
  mutate(Date = as.Date(spotify$Date, "%m/%d/%Y")) %>%
  mutate(Track = as.character(Track))) %>% mutate(Rank = as.numeric(Rank))

head(spotifyM); tail(spotifyM)


Art10 <- spotifyM %>% group_by(Artist) %>% 
  summarise(Total = sum(Streams)) %>% 
  arrange(desc(Total)) %> %
  top_n(10, Total) 

ggplot(Art10, aes(x = reorder(Artist, Total), y = Total)) + coord_flip() + geom_col(fill = 'Blue')

PostMal <- filter(spotifyM, Artist == "Post Malone") %>% 
  group_by(Track) %>% 
  summarise(Total = sum(Streams)) %>%
  arrange(desc(Total))
View(PostMal)

PostMal <- filter(spotifyM, Artist == "Post Malone") %>% filter(Track == 'Sunflower - Spider-Man: Into the Spider-Verse')

ggplot(PostMal, aes(x=Date, y = Rank)) + geom_line() + scale_y_reverse() 

normalize <- function(x){
  norm <- (x - min(x))/(max(x) - min(x))
  norm
}

rank_normalize <- function(x){
  normRank <- (max(x)-x)/(max(x)-min(x))
}

PostMal <- mutate(PostMal, Stream_norm = normalize(PostMal$Streams)) %>% 
  mutate(Rank_norm = rank_normalize(PostMal$Rank))


ggplot(PostMal, aes(Date)) +                    # basic graphical object
  geom_line(aes(y=Stream_norm), colour="red")+  # first layer
  geom_line(aes(y=Rank_norm), colour="green")



                                                                        