#!/bin/env bash

# systemd example: https://stackoverflow.com/a/50321912
# cron example:
# 0 * * * * ~/.config/sway/scripts/bing_wallpaper.sh

# exit on error
set -e

# for systemd or cron
export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock

wlpath=${WALLPAPER_PATH:-"$HOME/wallpaper.jpg"}
output=${WALLPAPER_OUTPUT:-"*"}
baseurl="https://www.bing.com/"
wluri=$(curl $baseurl"HPImageArchive.aspx?format=js&idx=0&n=20&mkt=en-US" -s | jq '.images[].url' --raw-output | shuf -n 1)

curl "$baseurl$wluri" -s > $wlpath

killall swaybg || true

swaymsg "output $output bg $wlpath fill"
