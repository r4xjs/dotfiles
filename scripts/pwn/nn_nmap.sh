#!bin/zsh

nn_nmap_all_ports(){
    print -z 'sudo nmap --nsock-engine epoll --defeat-rst-ratelimit -n -vvv -sS -T4 -oA all_tcp_ports -p- '
}
