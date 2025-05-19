#!/bin/bash

sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -I 128x32
#sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -c
#while :
#do
ip_address=$(hostname -I)
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -r 0
cpu_temp=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -c1
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -x 0 -y 1
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -l "CPU: $cpu_temp"

if nmcli -t -f DEVICE,STATE device | grep -q '^wlan0:connected$'; then
        ssid=$(nmcli -t -f ssid dev wifi | grep -E '^[^:]+$' | head -n 1)
        sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -c2
		sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -x 0 -y 2
		sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -l $ssid
else
        ssid=$(iw dev | grep ssid | awk '{print $2}')
        if [ -z $ssid ]; then
				sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -c2
                sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -x 0 -y 2
                sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -l "Disconected (LAN)"
        else
                sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -c2
				sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -x 0 -y 2
                sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -l "AP"
                sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -x 15 -y 2
                sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -l $ssid
        fi
fi

sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -c3
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -x 0 -y 3
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -l $ip_address
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -c0
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -x 90 -y 0
sudo /home/orangepi/opizero-display/ssd1306_bin -n 8 -l $(TZ=Europe/Samara date +%H:%M)
#done