#!/usr/bin/env bash

# source https://www.reddit.com/r/swaywm/comments/bdseiq/modreturn_to_open_new_termite_window_in_the_same/el0h6js?utm_source=share&utm_medium=web2x

terminal=${1:-alacritty}
pid=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.type=="con") | select(.focused==true).pid')
pname=$(ps -p ${pid} -o comm= | sed 's/-$//')

wpath=$HOME

if [[ $pname == $terminal ]]
then
  ppid=$(pgrep --newest --parent ${pid})
  wpath=$(readlink /proc/${ppid}/cwd || print $HOME)
fi

$terminal --working-directory $wpath
