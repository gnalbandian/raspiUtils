#!/bin/bash
export DISPLAY=:0

if [[ $1 ]]
then
        Custom_pid=`pgrep $1`
        Custom_wid=`xdotool search --onlyvisible --pid $Custom_pid 2>/dev/null | head -n 1`
        xdotool windowactivate --sync $Custom_wid
else
        Jivelite_pid=`pgrep jivelite`
        Epiphany_pid=`pgrep epiphany-browse`
        Jivelite_wid=`xdotool search --onlyvisible --pid $Jivelite_pid 2>/dev/null | head -n 1`
        Epiphany_wid=`xdotool search --onlyvisible --pid $Epiphany_pid 2>/dev/null | head -n 1`

        Active_wid=`xdotool getactivewindow`
        if [ $Active_wid -eq $Jivelite_wid ]
        then
                xdotool windowactivate --sync $Epiphany_wid
        else
                xdotool windowactivate --sync $Jivelite_wid
        fi
fi
exit 0;
