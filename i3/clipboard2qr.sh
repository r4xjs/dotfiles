#!/bin/sh
qrencode "$(xsel -ob)" -o -  | feh -
