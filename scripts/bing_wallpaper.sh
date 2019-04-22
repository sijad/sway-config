#!/bin/env bash

# exit on error
set -e

wlpath=${WALLPAPER_PATH:-"$HOME/wallpaper.jpg"}
wluri=$(curl 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' -s | jq '.images[0].url' --raw-output)

curl "https://www.bing.com$wluri" -s > $wlpath

killall swaybg || true

swaymsg "output * bg $wlpath fill"
