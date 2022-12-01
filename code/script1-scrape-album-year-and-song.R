# Title: Scrape information of U2 Songs
# Description: Harvesting album, year, name of song, and its hyperlink
# Inputs: 
# U2 lyrics webpage from AZLyrics website
# - https://www.azlyrics.com/u/u2band.html
# Output:
# CSV file "u2-songs-info.csv" containing 4 variables:
# - name of album
# - year of album
# - name of song (in a given album)
# - hyperlink of song's lyrics
#
# Note: hyperlinks are used in script2 to download html files
#
# Author: Gaston Sanchez


# packages
library(tidyverse)
library(xml2)
library(rvest)


# ----------------------------------------------------------------------
# The webpage "https://www.azlyrics.com/u/u2band.html" contains the list
# of all U2 albums and their songs.
#
# From this html document, we can extract the following:
# - name of album
# - year of album
# - name of song (in a given album)
# - hyperlink of song's lyrics
#
# To extract these variables, we need the set of auxiliary functions
# listed in the next section "Helper Functions"
# ----------------------------------------------------------------------


# -----------------------------------------------
# Helper Functions
# -----------------------------------------------
# all the functions listed below take an input "string"
# this is a line of text from the html document u2band.html

is_album = function(string) {
  str_detect(string, 'class="album"')
}

is_song = function(string) {
  str_detect(string, 'class="listalbum-item"')
}

extract_title = function(string) {
  str_extract(string, regex('(?<=: <b>").*(?="</b>)'))
}

extract_year = function(string) {
  str_extract(string, regex('(?<=\\().*(?=\\))'))
}

extract_href = function(string) {
  str_extract(string, regex('(?<=href="/).*(?=" target)'))
}

extract_song = function(string) {
  str_extract(string, regex('(?<=_blank">).*(?=</a>)'))
}



# ----------------------------------------------------------------------
# Step 1: Download u2band.html
# ----------------------------------------------------------------------

base_url = "https://www.azlyrics.com/u/u2band.html"

download.file(base_url, destfile = "../data/u2band.html")

content = readLines('../data/u2band.html')


# ----------------------------------------------------------------------
# Step 2: Parse data from u2band.html; i.e. the following variables:
# - name of album
# - year of album
# - name of song (in a given album)
# - hyperlink of song's lyrics
# ----------------------------------------------------------------------

# look within lines 170 and 456 (inclusive), which covers songs
# from album: "Boy" (1980)
# to album:   "Songs Of Experience" (2017)
#
# Note: we won't scrape data under the section "other songs" (line 457)

albums = NULL
years = NULL
hrefs = NULL
songs = NULL

# starting parsing content at line 170
i = 170

while (i < 457) {
  current_line = content[i]
  if (is_album(current_line)) {
    album_title = extract_title(current_line)
    album_year = extract_year(current_line)
    i = i + 1
    current_line = content[i]
    while (is_song(current_line)) {
      hrefs = c(hrefs, extract_href(current_line))
      song = extract_song(current_line)
      print(song)
      songs = c(songs, song)
      albums = c(albums, album_title)
      years = c(years, album_year)
      i = i + 1
      current_line = content[i]
    }
  }
  i = i + 1
}


# assemble data frame
dat = data.frame(
  album = str_remove_all(albums, "(&amp; )|(;)|(,)|(')"),
  year = years,
  song = songs,
  href = hrefs
)

head(dat)
tail(dat)

# export it to data/
write.csv(dat, file = "../data/u2-songs-info.csv", row.names = FALSE)
