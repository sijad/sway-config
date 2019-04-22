#!/bin/env bash

set -e

wlpath=$(curl 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' -s | jq '.images[0].url' --raw-output)

curl "https://www.bing.com$wlpath" -s > ~/wallpaper.jpg

killall swaybg

swaymsg 'output * bg ~/wallpaper.jpg fill'
