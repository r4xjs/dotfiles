#!bin/zsh

nn_nmap_tcp_all_ports(){
    print -z 'sudo nmap --nsock-engine epoll --defeat-rst-ratelimit -n -vvv -sS -d -T4 -oA all_tcp_ports -p- '
}

nn_nmap_tcp_sCV(){
    print -z 'while read -r t; do host=${t%%:*};ports=${t##*: }; sudo nmap -sCV -p "$ports" -oA "${host}_sCV" -vvv -d "$host"  ; done <<(/home/user/.scr/pwn/gnmap_open_ports < **/*.gnmap)'
}

nmap_ip_list(){
    nmap -sL -n -iL "$1" | cut -d' ' -f5 | grep -P '^\d' --color=never 
}

nn_nmap_list_scripts(){
    script_path=/usr/share/nmap/scripts/
    vim "${script_path}$(find $script_path -type f -printf '%f\n' | fzf)"
}
