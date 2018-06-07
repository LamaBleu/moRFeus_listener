#!/bin/bash

morf_tool_dir=/home/pi/moRFeus_listener


source $morf_tool_dir/get_status.sh

#######

echo "


*** moRFeus remote control
*** LamaBleu 05/2018


moRFeus listener commands :
-----------------------

S : display status
F 123456789  : set frequency to 123456789 Hz
M [x] : switch to Mixer mode, power value = x
G [x] : switch to Generator mode, power value = x
P x : set Current value to x
X or Q : disconnect
KK : disconnect and KILL server
"

get_status

#while true; do

while :
do
command=""
freq=""
#morf_com=""
arg1=""
power=""
mode=""

read -e -r morf_com


command=$(echo $morf_com | awk '{print $1}')
arg1=$(echo $morf_com | awk '{print $2}')
arg1=${arg1//[![:digit:]]}

power=$(sudo $morf_tool_dir/morfeus_tool getCurrent)

case $command in
	[Ff]) echo "    **** setFrequency $arg1"
		if [ -z "$arg1" ]; then arg1=""; fi
		sudo $morf_tool_dir/morfeus_tool setFrequency $((arg1)); arg1=""
		get_status;
		;;
	[XxQq]) echo "       **** DISCONNECT "
		echo "       Goodbye. "
		exit 0;
		;;
	[Ss]) get_status;
		;;
	KK) echo "Disconnect and kill server - Goodbye forever !"
		sudo killall socat
		exit 0;
		;;
	[Mm]) if [ -z "$arg1" ]; then arg1=$power; fi
		echo "    **** set Mixer mode  - Power $arg1"
		sudo $morf_tool_dir/morfeus_tool Mixer
		sudo $morf_tool_dir/morfeus_tool setCurrent $((arg1))
		get_status;
		;;
	[Pp]) if [ -z "$arg1" ]; then arg1=$power; fi
		echo "    **** set Current  - Power $arg1"
		sudo $morf_tool_dir/morfeus_tool setCurrent $((arg1))
		get_status;
		;;
	[Gg]) if [ -z "$arg1" ]; then arg1=$power; fi
		echo "    **** set Generator mode  - Power $arg1"
		sudo $morf_tool_dir/morfeus_tool Generator
		sudo $morf_tool_dir/morfeus_tool setCurrent $((arg1))
		get_status;
		;;
	*) command=""
		freq=""
		morf_com=""
		arg1=""
		get_status;
		;;
esac


command=""
freq=""
morf_com=""
arg1=""

done


