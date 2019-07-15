#!/bin/bash
# ------------------ JSON START ------------------------ #
echo -n "{"

# ------------------- TIMESTAMP ------------------------ #
echo -n "\"timestamp\" : "
echo -n "\"`date -u '+%FT%T.000Z'`\", "

# ------------------- HOSTNAME ------------------------- #
echo -n "\"hostname\" : "
echo -n "\"`hostname`\", "

# --------------------- IP ----------------------------- #
echo -n "\"ip\" : "
echo -n "\"`hostname -I`\","

# ------------------ HITUNG USER LOGIN ----------------- #
echo -n "\"users_sedang_login\":\""
uptime | grep -ohe '[0-9.*] user[s,]' | awk '{ print $1 "\","}'

# ---------------------- UPTIME ------------------------ #
echo -n "\"uptime\" : \""
uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" "$3 "\", " }'
#echo -n "\", "

# -------------------- CEK SERVICES -------------------- #
echo -n "\"services\": { "
SERVICE=httpd
if ps ax | grep -v grep | grep $SERVICE > /dev/null; then echo -n "\"$SERVICE\" : \"running\","; else echo -n "\"$SERVICE\" : \"not running\","; fi
SERVICE=sshd
if ps ax | grep -v grep | grep $SERVICE > /dev/null; then echo -n "\"$SERVICE\" : \"running\""; else echo -n "\"$SERVICE\" : \"not running\""; fi
echo -n " }, "

# --------------------- CEK DISK ----------------------- #
echo -n "\"disk\" : { ";
echo -n "\""
df -h --total | awk  ' /total/ { print "total\" : \""$2"\", \"used\" : \""$3"\", \"free\" : \""$4"\", \"percentage\" : \""$5"\'\"' " }'
echo "},"

# --------------------- CEK MEMORY --------------------- #
echo -n "\"memory\" : { ";
echo -n "\"free_ram\" : \""
free -m | grep -v shared | awk '/Mem/ {printf $4 }'
echo -n "\", "
echo -n "\"total_ram\" : \""
free -m | grep -v shared | awk '/Mem/ {printf $2 }'
echo '",'

# -------------------- JSON CLOSE ---------------------- #
echo -n "\"json_close\" : \"close\""
echo " }} "

