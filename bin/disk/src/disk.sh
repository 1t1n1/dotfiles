#!/bin/bash

PROGRAM_LOCATION=~/bin/dotfiles/bin/disk/
PARTITION=/home

data_output=($(df -h $PARTITION | tail -1))
used_space=${data_output[4]}

if [[ ! -d $PROGRAM_LOCATION/data ]]; then
    mkdir $PROGRAM_LOCATION/data
fi

output_filename=../data/$(echo $PARTITION | sed 's/\//_/g' | sed 's/^_//')_used_space
echo $used_space > $output_filename 
