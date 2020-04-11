#!/bin/sh
/usr/bin/i3-msg "restart"
sleep 1
/usr/bin/xmodmap ~/.xmodmap
echo "$DISPLAY" > /tmp/log

