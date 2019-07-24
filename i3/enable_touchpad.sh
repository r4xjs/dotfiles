#!/bin/sh
xinput set-prop "SynPS/2 Synaptics TouchPad" --type=float "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "Tap Action" 2,3,0,0,1,3,0
