#!/bin/sh
xinput set-prop "SynPS/2 Synaptics TouchPad" --type=float "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "Tap Action" 0,0,0,0,0,0,0
xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Off" 1
