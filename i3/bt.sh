#!/bin/bash
cmd="$1"
echo -e "${cmd} 04:5D:4B:DE:25:67\nquit\n" | bluetoothctl
