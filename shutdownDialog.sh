#!/bin/bash

zenity_pid=`pgrep zenity`
if [[ $zenity_pid ]]
then
        kill $zenity_pid
else

  ACTION=`zenity --width=90 --height=170 --list --window-icon=question --timeout=10 --radiolist --text="Select logout action" --title="Logout" --column "Choice" --column "Action" TRUE Cancel FALSE Shutdown FALSE Reboot`

  if [ -n "${ACTION}" ];then
    case $ACTION in
    Shutdown)
      zenity --question --text "Are you sure you want to halt?" && sudo shutdown -ah now
      ;;
    Reboot)
      zenity --question --text "Are you sure you want to reboot?" && sudo reboot
      ;;
    esac
  fi
fi
