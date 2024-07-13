#!/bin/bash

current_mic_name=$(pactl get-default-source)
echo $(pamixer --list-sources | grep $current_mic_name | awk '{ print $1 }')
