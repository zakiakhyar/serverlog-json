tmp=$(echo -n "\"services\": { ")
SERVICES=(nginx httpd mysqld sshd chronyd snmpd)
tLen=${#SERVICES[*]}

for ((i=0; i<${tLen}; i++));
        do
                if ps ax | grep -v grep | grep ${SERVICES[$i]} > /dev/null; then tmp=$tmp$(echo -n "\"${SERVICES[$i]}\" : \"running\","); else tmp=$tmp$(echo -n "\"${SERVICES[$i]}\" : \"not running\","); fi
        done
tmp="${tmp::-1}"
tmp="$tmp },"
echo $tmp;

printf "\n"

halo zaki