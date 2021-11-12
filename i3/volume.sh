#!/bin/bash
python3 ~/.i3/set-default-sink.py
sink=$(pacmd info | grep "Default sink" | cut -d' ' -f 4)
volume_changed=/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga

if [ "${1}" == "up" ]; then
    pactl -- set-sink-volume $sink +5% && paplay -d $sink --volume 100000 $volume_changed
elif [ "${1}" == "down" ]; then 
    pactl -- set-sink-volume $sink -5% && paplay -d $sink --volume 100000 $volume_changed
elif [ "${1}" == "mute" ]; then 
    pactl -- set-sink-volume $sink 0
fi
