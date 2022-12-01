# Title: Scrape text of U2 Lyrics
# Description: Scrape text of lyrics
# Inputs: 
# HTML files in folder html-files/
# - The name of these files have the form: "album-year-song.html"
# - e.g. "Boy-1980-iwillfollow.html"
# Output:
# CSV file "u2-lyrics.csv" containing 4 variables:
# - name of album
# - year of album
# - name of song (in a given album)
# - text of lyric
#
# Author: Gaston Sanchez


# packages
library(tidyverse)
library(xml2)
library(rvest)



# -----------------------------------------------
# Helper Function
# -----------------------------------------------
# auxiliary function for scraping text lyrics
# input: character vector with html content, e.g. "Boy-1980-iwillfollow.html"
# output: character vector with lyrics text

extract_lyrics = function(txt) {
  # line at which lyrics text starts
  k = grep("<!-- Usage of azlyrics.com", txt) + 1
  lyrics_start = k
  
  # line at which lyrics text ends
  while (!str_detect(txt[k], "</div>")) {
    k = k + 1
  }
  lyrics_end = k - 1
  
  lyrics_raw = txt[lyrics_start:lyrics_end]
  lyrics_raw = str_remove(lyrics_raw, "<br>")
  lyrics_raw = str_remove_all(lyrics_raw, "&quot;")
  lyrics_raw = str_remove_all(lyrics_raw, "<i>.*</i>")
  lyrics_raw = lyrics_raw[str_detect(lyrics_raw, "^\\(", negate = TRUE)]
  #  lyrics_raw = lyrics_raw[str_detect(lyrics_raw, "^<i>", negate = TRUE)]
  lyrics_raw = lyrics_raw[lyrics_raw != ""]
  paste(lyrics_raw, collapse = " ")
}



# ----------------------------------------------------------------------
# Scrape text of lyrics from each html file
# ----------------------------------------------------------------------

dat = read.csv("../data/u2-songs-info.csv")

# adding column file (name of html file)
dat$file = paste(
  str_replace_all(dat$album, " ", "-"),
  dat$year,
  str_extract(dat$href, "\\w+\\.html$"), 
  sep = "-")

# initialize vector (to be populated with lyrics text)
text_lyrics = rep("", nrow(dat))

# extract lyrics from html files
for (i in 1:nrow(dat)) {
  current_file = paste0("../hmtl-files/", dat$file[i])
  current_txt = readLines(current_file)
  text_lyrics[i] = extract_lyrics(current_txt)
}

dat$lyrics = text_lyrics

# export ti to folder data/
write.csv(dat[ ,c(1:3, 6)], file = "../data/u2-lyrics.csv", row.names = FALSE)
