#!/bin/sh

ssid=$(wpa_cli scan_result | rofi -dmenu | awk -F'\t' '{print $5}')
idx=$(wpa_cli list_network | grep -P "\s+${ssid}\s+" | awk -F'\t' '{print $1}')
if [ "$idx" -eq "$idx" ] 2> /dev/null; then
    wpa_cli select_network "$idx"
fi
