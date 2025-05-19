#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

while :
do
	clear
	echo "Menu:"
	echo "1. Setup display"
	echo "2. Remove all settings"
	echo "3. Exit"
	read -p 'Choose item: ' item
	clear
	
	if [ $item -eq 1 ]
	then
		sudo chmod +x /home/orangepi/opizero-display/update-display-info.sh
		sudo chmod +x /home/orangepi/opizero-display/opizero-display.sh
		sudo chmod +x ssd1306_bin
		sudo echo "alias opidisplay='/home/orangepi/opizero-display/opizero-display.sh'" >> /home/orangepi/.bashrc
		source /home/orangepi/.bashrc
		sudo cp -f /home/orangepi/opizero-display/display-info.service /etc/systemd/system/display-info.service
		sudo cp -f /home/orangepi/opizero-display/display-info.timer /etc/systemd/system/display-info.timer
		sudo systemctl daemon-reexec
		sudo systemctl daemon-reload
		sudo systemctl enable --now display-info.timer
		echo "Reboot?"
		echo "1. Yes"
		echo "2. No"
		read -p 'Choose item: ' item
		if [ $item -eq 1 ]
		then
			sudo reboot now
		fi	
	elif [ $item -eq 2 ]
	then
		sudo systemctl stop display-info.timer
		sudo systemctl disable display-info.timer
		sudo rm /etc/systemd/system/display-info.service
		sudo rm /etc/systemd/system/display-info.timer
		sudo systemctl daemon-reexec
		sudo systemctl daemon-reload

	elif [ $item -eq 3 ]
	then
		exit
	fi
	sleep 2

done