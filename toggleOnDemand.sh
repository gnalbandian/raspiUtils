#!/bin/bash

Jivelite_pid=`pgrep -f jivelite`
Epiphany_pid=`pgrep -f epiphany-browser`
Jivelite_wid=`xdotool search --onlyvisible --pid $Jivelite_pid 2>/dev/null | head -n 1`
Epiphany_wid=`xdotool search --onlyvisible --pid $Epiphany_pid 2>/dev/null | head -n 1`

Active_wid=`xdotool getactivewindow`

if [ $Active_wid -eq $Jivelite_wid ]
then
        xdotool windowactivate --sync $Epiphany_wid
else
        xdotool windowactivate --sync $Jivelite_wid
fi

exit 0
