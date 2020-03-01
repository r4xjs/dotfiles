#!/usr/bin/zsh

pass=/usr/bin/pass
fzf_pass(){
    find "$HOME"/.password-store -iname "*.gpg" | sed "s/\.gpg//g;s#\./##g;s#$HOME/.password-store/##g" | rofi -dmenu -i 
}

mode="$1"

if [ "$mode" = "password" ];then
    $pass show --clip=1 "$(fzf_pass)"
elif [ "$mode" = "username" ]; then
    $pass show "$(fzf_pass)" | grep "login: " | cut -d' ' -f2 | xclip -selection clipboard
elif [ "$mode" = "autotype" ]; then
    content=$($pass show "$(fzf_pass)")
    password="$(echo $content | head -1)"
    username="$(echo $content | grep 'login: ' | cut -d' ' -f2)"
    sleep 0.2
    xdotool type "$username"
    sleep 0.2
    xdotool key Tab

    # will leak password in cmdline
    # exploitable like so: while true; do ps aux | grep xdotool | grep -v "grep"; done
    # ignored because attacker could also start keylogger oder grep the clipboard (in mode=password)
    # ...
    # should probably avoid it anyway. 
    # For example when the system logs all commands somewhere in a logfile i am screwed
    # all passwords that where used on the system will be leaked then when the attacker gets access to the log file :-/
    xdotool type "$password"
    sleep 0.2
    xdotool key Return
fi
