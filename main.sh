#!/bin/bash

## this will pull the ssid and password of all the wifi connection on the system

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

PKG_NAME='wipass'
INSTALL_DIR="/opt/$PKG_NAME/"
NM_PATH='/etc/NetworkManager/system-connections/'  #### NM stands for network manager
symbol='=>' 


function show_all {

    echo
    echo
    
    for file in `ls  $NM_PATH`; do
	
	fpath="$NM_PATH$file"
	ssid=$(cat $fpath | grep ssid= | cut -d'=' -f 2)
	pass=$(cat $fpath | grep psk=  | cut -d'=' -f 2)

	[[ ! -z "ssid" && ! -z "$pass" ]] && echo -e "$ssid $symbol \e[31m$pass\e[0m"
	
    done
    echo
}

function show_ssids {

    echo
    echo
    
    for file in `ls  $NM_PATH`; do
	
	fpath="$NM_PATH$file"
	ssid=$(cat $fpath | grep ssid= | cut -d'=' -f 2)

	[[ ! -z "ssid" ]] && echo -e "$ssid"
	
    done
    echo
}


function usage {

    echo -e "Usage:  wipass [OPTIONS]";
    echo -e "\t-a | --all\tShow All [default]"
    echo -e "\t-s | --ssids\tShow all ssid"
    echo -e "\t-h | --help\tShow the help"
    echo -e "\t-v | --version\tVersion Infomation"
 }

while true; do

    case $1 in

	-a|--all)      show_all; exit;;
	-h|--help)     usage; exit;;
	-s|--ssids)    show_ssids; exit;;
	-v|--version)  cat "$INSTALL_DIR.version"; exit;;
	*)            usage; exit;;

    esac
    
done

show_all
# restore $IFS
IFS=$SAVEIFS
