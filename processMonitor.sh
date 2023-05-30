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

oldProcess=$(ps -eo user,command)

# Hide cursor
tput civis

while true;do
	newProcess=$(ps -eo user,command)
	diff <(echo "$oldProcess") <(echo "$newProcess") | grep "[\>\<]" | grep -vE "command|processMonitor|playerctl|kworker"
	oldProcess=$newProcess
done
