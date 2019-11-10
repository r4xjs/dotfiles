#!/bin/bash
dgwip=$(ip r | grep default | cut -d' ' -f3)
dgwif=$(ip n | grep $dgwip | cut -d' ' -f3)
dgwmac=$(ip n | grep $dgwip | cut -d' ' -f5)
echo "found default gw: $dgwip -> $dgwmac"
echo "flushing $dgwif"
ip n flush dev "$dgwif"
echo "adding static arp table entry:"
echo "ip n add $dgwip lladdr $dgwmac dev $dgwif nud permanent"
ip n add "$dgwip" lladdr "$dgwmac" dev "$dgwif" nud permanent
