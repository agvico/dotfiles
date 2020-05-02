#!/bin/bash
ICON=$HOME/.i3/lock.png
TMPBG=/tmp/screen.png
import -window root $TMPBG
convert $TMPBG -swirl 215 -spread 7 $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -i $TMPBG
sleep 1
exit 0
