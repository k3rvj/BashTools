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

# Function open/closed
function portStatus(){
    (exec 3<> /dev/tcp/$1/$2) 2>/dev/null

    if [ $? -eq 0 ]; then
        echo -e "${turquoiseColour} [+] Host $1 ${endColour}${grayColour}-${endColour} ${turquoiseColour}Port: [ $2 ] ${endColour} ${purpleColour}( Open )${endColour}"
    fi
    
    exec 3<&-
    exec 3>&-
}

# Port arrray [1-65535]
declare -a ports=($(seq 1 65535))

# Hide cursor
tput civis

# If the first argument exists
if [ $1 ];then
    # Iterate the array
    for port in ${ports[@]};do
        portStatus $1 $port &
    done
else
    echo -e "\n${redColour}[!] Usage: ./portScan.sh <ip-address> [!]${endColour}"
fi

# Unhide cursor
tput cnorm

wait
