#!/bin/sh

SC_FILE=$HOME/Pictures/$(date '+%Y-%m-%d-%T')-screenshot.png
slurp | grim -g - $SC_FILE
wl-copy -t text/uri-list file://$SC_FILE
