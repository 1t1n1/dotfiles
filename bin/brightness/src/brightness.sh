#!/bin/bash

#############################################
##                 CONSTANTS               ##  
#############################################

COMMAND=$1 
ADJUSTMENT_PERCENTAGE=$2

# TODO : Change to use a config file

BRIGHTNESS_PATH=/sys/class/backlight/intel_backlight
MAX_BRIGHTNESS=$(cat $BRIGHTNESS_PATH/max_brightness)
MIN_BRIGHTNESS=0
CURRENT_BRIGHTNESS=$(cat $BRIGHTNESS_PATH/brightness)
PROGRAM_LOCATION=~/bin/dotfiles/bin/brightness

#############################################
##                 FUNCTIONS               ##  
#############################################

print_usage() {
    echo "TODO : Complete usage"
}

clamp_brightness() {
    if [[ $new_brightness -gt $MAX_BRIGHTNESS ]]; then
        new_brightness=$MAX_BRIGHTNESS
    elif [[ $new_brightness -lt $MIN_BRIGHTNES ]]; then
        new_brightness=$MIN_BRIGHTNESS
    fi
}

output_to_file() {
    if [[ ! -d $PROGRAM_LOCATION/data ]]; then
        mkdir $PROGRAM_LOCATION/data
    fi
    echo $(($new_brightness * 100 / $MAX_BRIGHTNESS)) > $PROGRAM_LOCATION/data/current_brightness
}

adjust_brightness() {
    adjustment=$(($ADJUSTMENT_PERCENTAGE * $MAX_BRIGHTNESS / 100))
    new_brightness=$(($CURRENT_BRIGHTNESS $operator $adjustment))

    clamp_brightness

    if [[ $new_brightness -le $MAX_BRIGHTNESS ]]; then
        sh -c "echo $new_brightness > $BRIGHTNESS_PATH/brightness"
    fi

    output_to_file
}

main() { 
    if [[ -z $COMMAND ]]; then
        echo $(($CURRENT_BRIGHTNESS * 100 / $MAX_BRIGHTNESS))
        exit
    fi

    case $COMMAND in
        "--inc" | "-i")
            echo "Brightness was $CURRENT_BRIGHTNESS" 
            operator='+'
            ;;
        "--dec" | "-d")
            echo "Brightness was $CURRENT_BRIGHTNESS" 
            operator='-'
            ;;
        *)
            print_usage
            exit
            ;;
    esac
    
    adjust_brightness
}

#############################################
##                  MAIN                   ##  
#############################################

main
