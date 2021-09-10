#!/bin/bash
xhost +local:${USER} || exit 1
Xephyr -screen 800x600 -reset -terminate -extension GLX 2>/dev/null :1 &
export DISPLAY=:1
echo 
echo "Now in nested zsh shell @ DISPLAY=:1, type exit to leave"
zsh