nn_gobuster(){
    print -z 'gobuster dir -t 20 -w wordlist -o logfile -k -l -u baseurl'
}

nn_amass(){
    print -z 'amass enum -df domains.lst -oA domains'
}

nn_hydra_basicauth(){
    print -z 'hydra -L userlist.txt -P passlist.txt -t 20 -s 443 -S -f -o out.log host https-get /path'
}

nn_hashcat_rules(){
    print -z 'hashcat --stdout password.lst --rules /usr/share/hashcat/rules/best64.rule'
}

nn_wfuzz(){
    print -z "wfuzz -c -t 2 -f $(pwd)/out.log -z file,$(pwd)/u.lst -z file,$(pwd)/pass.lst -d 'post-data=FUZZ&x=FUZ2Z' 'https://targetlalal'"
}

