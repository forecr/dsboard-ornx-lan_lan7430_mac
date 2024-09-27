#!/bin/bash
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'          # Red
YELLOW='\033[0;33m'       # Yellow
GREEN='\033[0;32m'        # Green
COLOR_OFF='\033[0m'       # Text Reset

if [ "$(whoami)" != "root" ] ; then
	echo -e "${RED}Please run as root${COLOR_OFF}"
	echo -e "${RED}Quitting ...${COLOR_OFF}"
	exit 1
fi

echo "Searching LAN7430 Ethernet interfaces"
lan743x_counter=$(($(lspci | grep Microchip | grep 7430 | wc -l)))
echo -e "    ${GREEN}Found $lan743x_counter lan7430 device(s).${COLOR_OFF}"

if (( lan743x_counter > 0 )); then
	echo "Interface name(s):"
	# Find each lan743x's Ethernet name
	declare -a net_name_list
	for net_iface_info in $(ls /sys/class/net/*/device/uevent)
	do
		index=$(cat $net_iface_info | grep DRIVER= | sed 's/DRIVER=//g')
		#echo "$index"

		if [ "$index" == "lan743x" ]; then
			net_name=$(echo $net_iface_info | sed 's/\/sys\/class\/net\///g' | sed 's/\/device\/uevent//g')
			echo -e "    ${GREEN}$net_name${COLOR_OFF}"
			net_name_list+=( "$net_name" )
		fi
	done
	echo ""
fi

echo "Done."

