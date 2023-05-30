#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Function exit
function ctrl_c(){
    echo -e "${redColour}\n[!] >> Exiting << [!]${endColour}\n"
    tput cnorm 
    exit 1
}

#Ctrl+C
trap ctrl_c SIGINT

# Hide cursor
tput civis

# iterate 
if [ $1 ];then
    for i in $(seq 1 254); do
        # First option
        timeout 1 bash -c "ping -c 1 $1.$i" &>/dev/null && echo -e "${redColour}[+] Host $1.$i UP [+]${endColour}" &
        # Second option
        # timeout 1 bash -c "echo '' > /dev/tcp/$1/$i" 2>/dev/null && echo -e "${redColour}[+] Host $1.$i UP [+]${endColour}" &
    done
else
    echo -e "\n${redColour}[!] Usage: ./portDiscovery.sh 192.168.0 [!]${endColour}"
fi

# Unhide cursor
tput cnorm

wait
