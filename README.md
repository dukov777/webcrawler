# webcrawler
Scripts for searching inside apple refurbished site.
Tested on MasOS Apple silicon 

# Installation
Install Chromium `brew install --cask chromium`

# Running the script

Scrape website `-u <url>` with pricecap `-p` of 2000$. If it finds a items bellow 2000$ dumps the matches and opens the website.

```node scrape.js -u https://www.apple.com/shop/refurbished/mac/512gb-2023-14-inch-macbook-pro-16gb -p 2000```


