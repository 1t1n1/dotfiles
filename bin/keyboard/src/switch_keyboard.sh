#!/bin/bash

PROGRAM_LOCATION=~/bin/dotfiles/bin/keyboard

if [[ ! -d $PROGRAM_LOCATION/data ]]; then
    mkdir $PROGRAM_LOCATION/data
    echo "us" > $PROGRAM_LOCATION/data/current_keyboard
fi

write_to_file() {
    echo $new_keyboard > $PROGRAM_LOCATION/data/current_keyboard
}

CURRENT_KEYBOARD=$(cat ~/bin/dotfiles/bin/keyboard/data/current_keyboard)
KEYBOARDS=(us ca)
NUMBER_OF_KEYBOARDS=${#KEYBOARDS[@]}
for (( i=0; i<$NUMBER_OF_KEYBOARDS; i++ )); do 
    if [[ ${KEYBOARDS[$i]} == $CURRENT_KEYBOARD ]]; then
        if [[ $i -eq $(($NUMBER_OF_KEYBOARDS-1)) ]]; then
            new_keyboard=${KEYBOARDS[0]} 
        else
            new_keyboard=${KEYBOARDS[$(($i+1))]}
        fi
    fi
done

setxkbmap $new_keyboard
write_to_file
