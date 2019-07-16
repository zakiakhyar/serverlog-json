#!/bin/bash

function d_start (){
while true 
do
	bash /opt/siatlog/infoserver.sh | tr '\n' ' ' > /tmp/infoserver.json;
	#curl -XPOST 'api.serverlog-json.com/api/insert/' --header 'Content-Type: application/x-www-form-urlencoded' -d "key=123&jsondata=@/tmp/infoserver.json";	
	curl -s -o -XPOST 'api.serverlog-json.com/api/insert/' --header 'Content-Type: application/x-www-form-urlencoded' -d "key=123&jsondata=`cat /tmp/infoserver.json`"
	sleep 30;
done &
}

function d_stop (){
pkill kirim
echo "Killing Process"
}

case $1 in
start )
d_start
;;
stop )
d_stop
;;
restart )
d_stop
sleep 1
d_start
;;
* )

exit 1
;;
esac

exit 0


