#!/bin/bash
# source: https://wiki.archlinux.org/title/Dunst#Tips_and_tricks

# Arbitrary but unique message tag
msgTag="myvolume"
sourceNumber=$(~/bin/dotfiles/bin/microphone/src/get_current_mic_number.sh)
sourceName=$(pamixer --list-sources | grep $sourceNumber | cut -d \" -f 6)

# Change the volume using pulseaudio 
pamixer --source $sourceNumber $@ > /dev/null

# Query amixer for the current volume and whether or not the speaker is muted
volume=$(pamixer --source $sourceNumber --get-volume-human)
mute=$(pamixer --source $sourceNumber --get-mute)
if [[ $volume == "0%" || "$mute" == "true" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:fgcolor:#80FFEA -h string:hlcolor:#80FFEA -h string:x-dunst-stack-tag:$msgTag "Microphone muted:" "$sourceName"
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -h string:fgcolor:#80FFEA -h string:hlcolor:#80FFEA -h string:x-dunst-stack-tag:$msgTag -h int:value:"$volume" "Microphone Volume: " "$sourceName "
fi

# Play the volume changed sound
# canberra-gtk-play -i audio-volume-change -d "changeVolume"
