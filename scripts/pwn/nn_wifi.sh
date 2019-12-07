#!/usr/bin/zsh

nn_airodump(){
    print -z 'sudo airodump-ng --output-format pcap,csv -w dump wlan1mon' 
}

nn_airo_deauth(){
    print -z 'sudo aireplay-ng --deauth 10 -c sta_mac  -e essid -a bssid  wlan1mon'
}
