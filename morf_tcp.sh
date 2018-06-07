#!/bin/bash
killall socat


morf_tool_dir=/home/pi/moRFeus_listener

## Telnet

socat TCP4-LISTEN:7778,fork,crlf,reuseaddr EXEC:$morf_tool_dir/morf_cli.sh,pty,stderr,echo=0 &

### telnet 192.168.0.21 7778
### echo "M 6" > /dev/tcp/192.168.0.21/7778
### echo "M 1" | nc 192.168.0.21 7778
### nc 192.168.0.21 7778



### UDP

socat UDP-l:7779,fork,reuseaddr EXEC:$morf_tool_dir/morf_cli.sh &


### echo "M 1" | nc -u -q3 192.168.0.21 7779




### HTTP status

socat TCP-LISTEN:7780,crlf,reuseaddr,fork SYSTEM:"echo 'HTTP/1.0 200'; echo 'Cache-Control\: no-cache'; echo 'Contentype\: text/plain'; sudo /home/pi/moRFeus_listener/get_status.http"




