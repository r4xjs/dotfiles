#!bin/zsh

nn_nmap_tcp_all_ports(){
    print -z 'sudo nmap --nsock-engine epoll --defeat-rst-ratelimit -n -vvv -sS -T4 -oA all_tcp_ports -p- '
}

nn_nmap_tcp_sCV(){
    print -z 'while read -r t; do host=${t%%:*};ports=${t##*: }; sudo nmap -sCV -p "$ports" -oA "${host}_sCV" -vvv "$host"  ; done <<(/home/user/.scr/pwn/gnmap_open_ports < **/*.gnmap'
}
