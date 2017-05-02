#!/bin/bash


YOUR_IP=$(ip route | awk 'FNR == 2 {print $9}')
TARGET_IP='Something/'
TARGET_SCAN=$(ip route | awk 'FNR == 3 {print $1}')
TARGET_GATEWAY=$(ip route | awk 'FNR == 1 {print $3}')

echo $YOUR_IP
echo $TARGET_SCAN
echo $TARGET_GATEWAY

function nmapSCAN {
	SCAN=REAL
	nmap -v -sn $TARGET_SCAN > NMAPscan$(date +%F)
}

function nmapGATEWAY {
	GATEWAY=REAL
	nmap -v -A $TARGET_GATEWAY > NMAPgateway$(date +%F)
}

function nmapSCANcopy {
if [[ -a NMAPscan$(date +%F) ]]
	then
		cp NMAPscan$(date +%F) /
fi
}

function nmapGATEcopy {
if [[ -a NMAPgateaway$(date +%F) ]]
	then
		cp NMAPgateway$(date +%F)
fi
}

function copyALL {
if [[ $(echo $NMAP $GATEWAY) = 'YES YES' ]]
	then
		cp NMAPgateway$(date +%F) /
		cp NMAPscan$(date +%F) /
fi
}

function ALLtoUSB {
if [[ $(echo $NMAP $GATEWAY) = 'YES YES' ]]
	then
		cp NMAPgateway$(date +%F) /media/USB/
		cp NMAPscan$(date +%F) /media/USB/
fi
}

function TSHARKwifi {
	tshark -w TsharkLog
}

function AIRODUMPwlan {
	airmon-ng start wlan0 11
	airodump-ng mon0 -w WLANhand/WLANhandshake
}

function AIRODUMPeth {
	airmon-ng start eth0 11
	airodump-ng eth0 -w ETHhand/ETHhandshake
}
