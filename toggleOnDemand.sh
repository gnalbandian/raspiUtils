#!/bin/bash

Jivelite_pid=`pgrep -f jivelite`
Epiphany_pid=`pgrep -f epiphany-browser`
Jivelite_wid=`xdotool search --onlyvisible --pid $Jivelite_pid >/dev/null | head -n 1`
Epiphany_wid=`xdotool search --onlyvisible --pid $Epiphany_pid >/dev/null | head -n 1`

Active_wid=`xdotool getactivewindow 2>/dev/null 2>&1`

if [ $Active_wid -eq $Jivelite_wid ]
then
  xdotool windowactivate $Epiphany_wid 2>/dev/null 2>&1
else
  xdotool windowactivate $Jivelite_wid 2>/dev/null 2>&1
fi
