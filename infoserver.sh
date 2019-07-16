#!/bin/bash
echo -n "{"

echo -n "{"
echo -n "\"timestamp\" : "
echo -n "\"`date -u '+%FT%T.000Z'`\", "
echo -n "\"hostname\" : "
echo -n "\"`hostname`\", "
echo -n "\"ip\" : "
echo -n "\"`hostname -I`\","
echo -n "\"users_sedang_login\":\""
uptime | grep -ohe '[0-9.*] user[s,]' | awk '{ print $1 "\","}'
echo -n "\"uptime\" : \""
uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" "$3 "\", " }'
#echo -n "\", "

# SERVICES #
echo -n "\"services\": { "
SERVICE=httpd
if ps ax | grep -v grep | grep $SERVICE > /dev/null; then echo -n "\"$SERVICE\" : \"running\","; else echo -n "\"$SERVICE\" : \"not running\","; fi
# Tambah service baru pisah dengan : echo -n "," 
	# SERVICE=httpd
	# if ps ax | grep -v grep | grep $SERVICE > /dev/null; then echo -n "\"$SERVICE\" : \"running\","; else echo -n "\"$SERVICE\" : \"not running\","; fi
	# echo -n ","

SERVICE=sshd
if ps ax | grep -v grep | grep $SERVICE > /dev/null; then echo -n "\"$SERVICE\" : \"running\""; else echo -n "\"$SERVICE\" : \"not running\""; fi
echo -n " }, "
# / SERVICE #

echo -n "\"disk\" : { ";
echo -n "\""
df -h --total | awk  ' /total/ { print "total\" : \""$2"\", \"used\" : \""$3"\", \"free\" : \""$4"\", \"percentage\" : \""$5"\'\"' " }'
echo "},"

echo -n "\"memory\" : { ";
echo -n "\"free_ram\" : \""
free -m | grep -v shared | awk '/Mem/ {printf $4 }'
echo -n "\", "
echo -n "\"total_ram\" : \""
free -m | grep -v shared | awk '/Mem/ {printf $2 }'
echo '",'

echo -n "\"json_close\" : \"close\""
echo " }} "

