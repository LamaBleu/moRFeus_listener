#!/bin/bash
morf_tool_path=$PWD
morf_tool_pi=/home/pi/moRFeus_listener

if [ ! -f $morf_tool_path/morfeus_tool ] ; then
 echo
    echo
    echo "Directory : " $morf_tool_path
    echo "Outernet morfeus_tool not found ! "

echo -n "Choose OS  32bits, 64bits or armv7 (Raspberry) [32/64/arm]:  "
read platform
case "$platform" in
	32) echo "32 bits"
	    wget -O $morf_tool_path/morfeus_tool https://archive.outernet.is/morfeus_tool_v1.6/morfeus_tool_linux_x32;
	    ;;
	64) echo "64 bits"
	    wget -O $morf_tool_path/morfeus_tool https://archive.outernet.is/morfeus_tool_v1.6/morfeus_tool_linux_x64;
	    ;;
	arm) echo "arm"
	    wget -O $morf_tool_path/morfeus_tool https://archive.outernet.is/morfeus_tool_v1.6/morfeus_tool_linux_armv7;
            ;;
	  *) echo "SORRY ! 32  64 or arm only  ! (or manual download : https:/archive.outernet.is/morfeus_tool_v1.6/ )"
	     exit 0;
	    ;;
esac
printf "\n\n\n"
printf "\n\n\n"
echo "Just in case we will NOW install socat package"
echo "(sudo apt-get install socat)"
printf "\n\n\n"
sudo apt-get install -y socat

fi

echo "Files : setting variable morf_tool_dir to : " $morf_tool_path

for file in morf_*
do
while read -r line
do
echo "${line/$morf_tool_pi/$morf_tool_path}"
done < "$file" > tempo && mv tempo "$file"
done


for file in get_status.*
do
while read -r line
do
echo "${line/$morf_tool_pi/$morf_tool_path}"
done < "$file" > tempo && mv tempo "$file"
done

chmod +x morf_*
chmod +x get_status*
chmod +x morfeus_tool
printf "\n\n\n"
echo "Seems morfeus_listener is now installed"
echo "sudo $morf_tool_path/morf_cli.sh to launch CLI"
echo "sudo $morf_tool_path/morf_tcp.sh & to launch server"
echo

