# Title: Download HTML files of U2 Songs
# Description: Harvesting album, year, name of song, and its hyperlink
# Inputs: 
# - base url: https://www.azlyrics.com/u/u2band.html
# - CSV file "u2-songs-info.csv"
# Output:
# - HTML files downloaded to directory "html-files/"
# - The name of these files have the form: "album-year-song.html"
# - e.g. "Boy-1980-iwillfollow.html"
#
# Author: Gaston Sanchez


# packages
library(tidyverse)

# we need the hyperlinks of the songs
# which are in column "href" of csv file
dat = read.csv("../data/u2-songs-info.csv")

base_url = "https://www.azlyrics.com/"

# download HTML files (of U2 songs) from azlyrics.com
# (this takes a while because of the sleeping time between each download)
for (i in 1:222) {
  song_url = paste0(base_url, dat$href[i])
  song_html = str_extract(song_url, "\\w+\\.html")
  aux_album = str_replace_all(dat$album[i], " ", "-")
  file_html = paste(aux_album, dat$year[i], song_html, sep = "-")
  print(paste0(i, ": ", song_html))
  download.file(song_url, paste0("../html-files/", file_html))
  # wait some seconds (so that we don't get blocked by azlyrics)
  Sys.sleep(runif(1, 5, 10))
}
