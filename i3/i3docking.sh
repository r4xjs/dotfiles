#!/bin/bash
# reset crtc... VGA1 keeps CRTC 2 after disconect and the third display can't get CRTC 2 then
#su user -c "export DISPLAY=:0; export XAUTHORITY=/home/user/.Xauthority; xrandr -s 0"
#sleep 3
#xrandr --output eDP-1 --mode 1920x1080 --primary
xset r rate 250 100
/usr/local/bin/wakeup_fix.sh
#xrandr --output HDMI-2 --mode 3840x2160  --primary --scale 0.9x0.9 --dpi 120
#xrandr --output DP-1-1 --mode 3840x2160  --primary --scale 0.9x0.9 --dpi 120
xrandr --output DP-1-1 --mode 3840x2160  --primary --scale 1.0x1.0 --dpi 120
xrandr --output DP-1-3 --auto  --left-of DP-1-1 
#xrandr --output DP-2-3 --auto --primary
xrandr --output eDP-1 --off
#xrandr --output DP-2-1 --mode 1920x1080 --crtc 0 --primary
#xrandr --output DP-2-2 --mode 1920x1080 --crtc 1 --left-of DP-2-1 
#xrandr --output DP-2-3 --mode 1280x1024 --left-of DP-2-2
#su user -c "export DISPLAY=:0; export XAUTHORITY=/home/user/.Xauthority; xrandr --output VGA1 --mode 1280x1024 --left-of DP2-2"
