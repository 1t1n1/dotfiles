#!/bin/bash

## Utility tool to handle ProtonVPN commands for polybar

COMMAND=$1 
SCRIPT_LOCATION=$(dirname $0)
DATA_DIRECTORY=$SCRIPT_LOCATION/../data

get_state_from_ip() {
	if [[ $(ip a | grep "proton0") ]]; then
		echo "Connected"
	else
		echo "Disconnected"
	fi

}

print_state() {
	state=$(read_state)
	if [ "$state" = "Disconnecting" ]; then
		echo "󰒘 Disconnecting... "
	elif [ "$state" = "Connecting" ]; then
		echo "󰦞 Connecting... "
	# Using `ip` is more reliable, but not possible
	# for transient states
	elif [[ $(ip a | grep "proton0") ]]; then
		echo "󰒘 "
	elif [[ -z $(ip a | grep "proton0") ]]; then
		echo "󰦞 "
	fi
}

write_state() {
	if [[ ! -d $DATA_DIRECTORY ]]; then
		mkdir -p $DATA_DIRECTORY
	fi

	echo $1 > $DATA_DIRECTORY/state
}

read_state() {
	cat $DATA_DIRECTORY/state
}

toggle_fastest_connection() {
	state=$(get_state_from_ip)
	if [[ $state == "Connected" ]]; then
		write_state "Disconnecting"
		$SCRIPT_LOCATION/protonvpn_toggler disconnect
		write_state "Disconnected"
	else
		write_state "Connecting"
		$SCRIPT_LOCATION/protonvpn_toggler connect_fastest
		write_state "Connected"
	fi
}

toggle_random_connection() {
	state=$(get_state_from_ip)
	if [[ $state == "Connected" ]]; then
		write_state "Disconnecting"
		$SCRIPT_LOCATION/protonvpn_toggler disconnect
		write_state "Disconnected"
	else
		write_state "Connecting"
		$SCRIPT_LOCATION/protonvpn_toggler connect_random
		write_state "Connected"
	fi
}

main() { 
    case $COMMAND in
        "s" | "status")
			print_state
            ;;
        "tf" | "toggle_fastest")
			toggle_fastest_connection
            ;;
		"tr" | "toggle_random")
			toggle_random_connection
			;;
      *)
            exit
            ;;
    esac
}

main

