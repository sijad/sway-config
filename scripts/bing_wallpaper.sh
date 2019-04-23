#!/bin/env bash

# exit on error
set -e

baseurl="https://www.bing.com/"
wlpath=${WALLPAPER_PATH:-"$HOME/wallpaper.jpg"}
wluri=$(curl $baseurl"HPImageArchive.aspx?format=js&idx=0&n=20&mkt=en-US" -s | jq '.images[].url' --raw-output | shuf -n 1)

curl "$baseurl$wluri" -s > $wlpath

killall swaybg || true

swaymsg "output * bg $wlpath fill"
