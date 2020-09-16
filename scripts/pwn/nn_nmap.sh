#!bin/zsh

nn_nmap_tcp_all_ports(){
    print -z 'sudo nmap --nsock-engine epoll --defeat-rst-ratelimit -n -vvv -sS -d -T4 -oA all_tcp_ports -p- '
}

nn_nmap_tcp_sCV(){
    print -z 'while read -r t; do host=${t%%:*};ports=${t##*: }; sudo nmap -sCV -p "$ports" -oA "${host}_sCV" -vvv -d "$host"  ; done <<(/home/user/.scr/pwn/gnmap_open_ports < **/*.gnmap)'
}

nn_nmap_smb_scan(){
    print -z 'nmap --script smb2-security-mode,smb2-capabilities,"smb-enum-*","smb-vuln-*",smb-ls,smb-server-stats,smb-system-info,smb-protocols,smb-print-text,smb-mbenum,smb2-vuln-uptime,smb-security-mode -p445 -oA smb_scrpits '
}

nn_nmap_heartbleed(){
    print -z 'while read -r t; do $(echo $t | awk "BEGIN{FS=\":\"} {printf \"nmap -p %s --script ssl-heartbleed %s\\n\",$2,$1}"); done < ~/w1/ip_colon_port.lst >> heartbleed.log'
}

nmap_ip_list(){
    nmap -sL -n -iL "$1" | cut -d' ' -f5 | grep -P '^\d' --color=never | sort -u
}

nn_nmap_list_scripts(){
    script_path=/usr/share/nmap/scripts/
    vim "${script_path}$(find $script_path -type f -printf '%f\n' | fzf)"
}
