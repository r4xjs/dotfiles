xdotool type "$(cat ~/.autotype.json| rofi -dmenu -i | jq -r .value)"
