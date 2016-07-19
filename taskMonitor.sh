#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
normal=$(tput sgr0)

LOG_FILE=/home/pi/taskMonitor.log
interval=2
criticalTasks="X matchbox"
primaryTasks="touchegg epiphany squeezelite jivelite"
secondaryTasks="sshd wpa_supplicant"

if [[ $1 == "-l" ]]
then
        echo -e "\e[4mCritical processes status\t[ Status ]\e[0m"
        for criticalProcess in $criticalTasks
        do
                if [ `pgrep $criticalProcess` ]
                then
                        printf "%-32s  %-30s\n" "$criticalProcess" "${green}[ OK ]${normal}"
                else
                        printf "%-31s  %-31s\n" "$criticalProcess" "${red}[ NOK! ]${normal}"
                fi
        done

        echo -e "\n\e[4mPrimary tasks status\t\t[ Status ]\e[0m"

        for primaryProcess in $primaryTasks
        do
                if [ `pgrep $primaryProcess` ]
                then
                        printf "%-32s  %-30s\n" "$primaryProcess" "${green}[ OK ]${normal}"
                else
                        printf "%-31s  %-31s\n" "$primaryProcess" "${red}[ NOK! ]${normal}"
                fi
        done
else
        while [ 1 ]
        do
                if [ `awk -F. '{print $1}' /proc/uptime` -gt 60 ]
                then
                        for criticalProcess in $criticalTasks
                        do
                                if [ `pgrep $criticalProcess || echo 0` -eq 0 ]
                                        then
                                                echo -e "`date +'%d/%m/%Y %H:%M'`: $criticalProcess \e[91mDOWN\e[0m. Rebooting system.\n" >> /home/pi/taskMonitor.log
                                                sudo reboot
                                        fi
                        done

                        for primaryProcess in $primaryTasks
                        do
                                if [ `pgrep $primaryProcess || echo 0` -eq 0 ]
                                then
                                        sudo systemctl restart $primaryProcess.service
                                        /bin/echo -e "`date +'%d/%m/%Y %H:%M'`: $primaryProcess \e[91mDOWN\e[0m. Restarting service.\n"  >> /home/pi/taskMonitor.log
                                fi
                        done
                fi
                sleep $interval
        done
fi
