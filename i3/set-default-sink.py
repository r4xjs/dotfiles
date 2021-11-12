#!/usr/bin/env python3

"""
pacmd list-sinks | grep -B1 "name:"
    index: 0
	name: <alsa_output.pci-0000_00_1f.3.analog-stereo>
--
    index: 1
	name: <alsa_output.usb-Conexant_CONEXANT_USB_AUDIO_000000000000-00.analog-stereo>
--
  * index: 6
	name: <bluez_sink.04_5D_4B_DE_25_67.a2dp_sink>
"""

import subprocess
import re

def get_all_sinks() -> dict:
    sink_index = None
    sink_name = None
    ret = dict()

    for line in subprocess.check_output(['/usr/bin/pacmd', 'list-sinks'])\
            .decode()\
            .split('\n'):
        if m := re.search(r'index: (\d+)', line):
            sink_index = int(m.group(1))
            continue
        if m := re.search(r'name: (\S+)', line):
            sink_name = m.group(1)
            ret[sink_index] = sink_name

    return ret

def set_default_sink(sink_idx):
    print(f"set default sink to {sink_idx}")
    subprocess.Popen(['pacmd', 'set-default-sink', str(sink_idx)])

if __name__ == "__main__":
    sinks  = get_all_sinks()
    new_default_sink = None

    # select default sink
    # if bluez sink is present take it otherwise fall back to alsa pci
    for (idx, name) in sinks.items():
        if 'alsa_output.pci' in name:
            new_default_sink = idx
        if 'bluez' in name:
            new_default_sink = idx
            break
    set_default_sink(new_default_sink)
