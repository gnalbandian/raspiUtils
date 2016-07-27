#! /bin/bash

function exit_func() {
	echo Exit function
	kill -9 $YAD_PID
}
export -f exit_func

function reboot_func() {
kill -9 $YAD_PID
yad --question --undecorated --borders=15 --on-top --center --text "Are you sure you want to reboot the system"
    
	if [[ "$?" == "0" ]]; then
		/sbin/reboot
    fi
}
export -f reboot_func

function network_func() {
	kill -9 $YAD_PID
	/usr/bin/wicd-gtk
}
export -f network_func

function screen_func() {
kill -9 $YAD_PID
XSCREENSAVER_STATUS=$(sudo systemctl status xscreensaver.service | grep Active: | awk '{if ($2 == "active") print "TRUE"; else print "FALSE"}')
VALUE=$(yad --question --width 280 --on-top --center --undecorated --scale --borders=15 --separator=, --form \
--field "Brightness:SCL" \
--field "Screensaver:CHK" '' "$XSCREENSAVER_STATUS")
ret=$?

echo $ret
if [[ $ret -eq 0 ]]
then
	echo $VALUE | awk -F, '{print $1}' > /sys/class/backlight/rpi_backlight/brightness
	if [[ `echo $VALUE | awk -F, '{print $2}'` == "FALSE" ]]
	then
		sudo systemctl stop xscreensaver.service
		sudo systemctl disable xscreensaver.service
	else
		sudo systemctl start xscreensaver.service
		sudo systemctl enable xscreensaver.service
	fi
	exit 0
fi

}
export -f screen_func

YADS_PIDS=$(pgrep yad)

if [ ! -z $YADS_PIDS ]
then
	kill -9 $YADS_PIDS
else
yad --width 280 --title "System Options" --no-buttons --center --on-top --undecorated --timeout=10 --borders=15 --image=gnome-shutdown --text "Choose action:" --form \
--field "Screen Configuration:FBTN" "bash -c screen_func" \
--field "Network Configuration:FBTN" "bash -c network_func" \
--field "Reboot:FBTN" "bash -c reboot_func" \
--field "Exit:FBTN" "bash -c exit_func"

fi
exit 0
