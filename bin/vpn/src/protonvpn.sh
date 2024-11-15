#!/bin/bash

## Utility tool to handle ProtonVPN commands for polybar

#----NOTE: If for some reason the program crashed and you're out of connection, do 
#---- nmcli device wifi connect <you_wifi>
#----It should restore the connection (without VPN, of course) :)

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
	elif [ "$state" = "Error" ]; then
		echo "󰦞 Correcting error... "
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
		check_integrity
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
		check_integrity
		write_state "Connected"
	fi
}

abort_and_disconnect() {
	current_wifi=$(nmcli connection show --active | head -n 2 | tail -n 1 | awk '{print $1}')
	nmcli device wifi connect $current_wifi
	write_state "Disconnected"
	exit
}

check_integrity() {
	start_time=$(date +%s)
	error1="Could not reach the VPN Server"
	error2="There was an error connecting to the ProtonVPN API"
	current_status=$(protonvpn status 2>&1)
	while [[ $(echo $current_status | grep "$error1") || $(echo $current_status | grep "$error2") ]]; do
		write_state "Error"
		$SCRIPT_LOCATION/protonvpn_toggler reconnect
		current_status=$(timeout 7s protonvpn status 2>&1)

		if [ echo $? -gt 0 ]; then
			# Getting vpn status shouldn't take 7+ seconds
			abort_and_disconnect
		fi

		current_time=$(data +%s)
		elapsed_time=$((current_time - start_time))
		if [ "$elapsed_time" -ge 10 ]; then
			abort_and_disconnect
		fi

		sleep 1
	done
	write_state "Connected"
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

