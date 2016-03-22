#!/bin/bash

# Now copy config files
cp -a -rv /mnt/storm/. .

############################
# storm.zookeeper.servers #
############################
if [ -z "$ZOOKEEPER_SERVERS" ]
then
    echo -e "Please provide \e[1;35mZOOKEEPER_SERVERS\e[0m like \"1.2.3.4\" or \"1.2.3.4,5.6.7.8\""
    return
fi

# All ZooKeeper server IPs in an array
IFS=', ' read -r -a ZOOKEEPER_SERVERS_ARRAY <<< "$ZOOKEEPER_SERVERS"
ZOOKEEPER_SERVERS_ESCAPED=
for index in "${!ZOOKEEPER_SERVERS_ARRAY[@]}"
do
    ZOOKEEPER_SERVERS_ESCAPED="$ZOOKEEPER_SERVERS_ESCAPED,${ZOOKEEPER_SERVERS_ARRAY[index]}"
done

ZOOKEEPER_SERVERS_ESCAPED="["${ZOOKEEPER_SERVERS_ESCAPED:1}"]"


exec bin/storm "$@" -c storm.zookeeper.servers=$ZOOKEEPER_SERVERS_ESCAPED \
   -c storm.zookeeper.servers=$ZOOKEEPER_SERVERS_ESCAPED \
   -c storm.local.hostname=$(hostname -i | awk '{print $1;}')
