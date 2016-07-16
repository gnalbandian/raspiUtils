#!/bin/bash

SERVER_IP=192.168.2.22
SERVICE_PORT=8080

#We test for reachability to the server
while ! ping -c1 $SERVER_IP >/dev/null 2>&1; do sleep 1; done;

#We test for HTTP service availability
while $((</dev/tcp/$SERVER_IP/$SERVICE_PORT )> /dev/null 2>&1 && echo false || echo true); do sleep 1; done;

export DISPLAY=:0
#matchbox-window-manager -use_cursor no -use_titlebar no & WEBKIT_DISABLE_TBS=1 epiphany-browser -a --profile /home/pi/.config  http://$SERVER_IP:$SERVICE_PORT/basicui/app
WEBKIT_DISABLE_TBS=1 epiphany-browser -a --profile /home/pi/.config  http://$SERVER_IP:$SERVICE_PORT/basicui/app

exit 0;
