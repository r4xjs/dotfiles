#!/bin/sh

sed 's/xrender=false/xrender=true\nVMARGS=-Dsun.java2d.uiScale=2\n/g' /opt/ghidra/support/launch.properties > /tmp/launch.properties
cp /opt/ghidra/support/launch.properties /opt/ghidra/support/launch.properties.orig
mv /tmp/launch.properties /opt/ghidra/support/launch.properties
