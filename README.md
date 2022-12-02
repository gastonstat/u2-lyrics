# Scraping U2 Lyrics

This repository contains the R scripts to scrape __U2 Lyrics__, 
as well as the scraped HTML files, and the assembled output CSV file.


## Source

The source of the U2 Lyrics data is:

<https://www.azlyrics.com/u/u2band.html>



## Description

[Scraping-U2-Lyrics-with-R.pdf](Scraping-U2-Lyrics-with-R.pdf)


## Data Table `u2-lyrics.csv`

The ultimate output of the R scripts is the CSV file `u2-lyrics.csv`.
This file has a data table with four columns:

1) `album`: name of album

2) `year`: year (in which album was published)

3) `song`: name of song

4) `lyrics`: text of transcript

This data set can be used for text mining purposes.


## Filestructure

```
README.md
Scraping-U2-Lyrics-with-R.pdf
code/
  script1-scrape-album-year-and-song.R
  script2-download-song-html-files.R
  script3-scrape-u2-lyrics-text.R
data/
  u2band.html
  u2-songs-info.csv
  u2-lyrics.csv
html_files/
	Boy-1980-adaywithoutme.html
	Boy-1980-ancatdubh.html
	...
	Songs-Of-Experience-2017-yourethebestthingaboutme.html
```


## Donation

As a Data Science and Statistics educator, I love to share the work I do.
Each month I spend dozens of hours curating learning materials like this resource.
If you find any value and usefulness in it, please consider making 
a <a href="https://www.paypal.com/donate?business=ZF6U7K5MW25W2&currency_code=USD" target="_blank">one-time donation---via paypal---in any amount</a> (e.g. the amount you would spend inviting me a cup of coffee or any other drink). Your support really matters.

<a href="https://www.paypal.com/donate?business=ZF6U7K5MW25W2&currency_code=USD" target="_blank"><img src="https://www.gastonsanchez.com/images/donate.png" width="140" height="60"/></a>
