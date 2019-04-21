#!/usr/bin/env bash

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
