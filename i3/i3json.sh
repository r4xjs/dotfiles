#!/bin/bash

echo "$(xsel -ob)" | jq | xclip -sel clip
