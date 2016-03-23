#!/bin/bash

# Now copy config files, if there are any
if [ -d "/mnt" ] && [ -d "/mnt/storm" ]; then
    echo "directory /mnt/storm/ exists. Copying contents into storm folder..."
    cp -a -rv /mnt/storm/. .
fi

# now let's build the command to start storm
CMD="exec bin/storm \"\$@\" -c storm.local.hostname=\$(hostname -i | awk '{print \$1;}')"

############################
# storm.zookeeper.servers #
############################
if ! [ -z "$ZOOKEEPER_SERVERS" ]; then
    # All ZooKeeper server IPs in an array
    IFS=', ' read -r -a ZOOKEEPER_SERVERS_ARRAY <<< "$ZOOKEEPER_SERVERS"
    ZOOKEEPER_SERVERS_ESCAPED=
    for index in "${!ZOOKEEPER_SERVERS_ARRAY[@]}"
    do
        ZOOKEEPER_SERVERS_ESCAPED="$ZOOKEEPER_SERVERS_ESCAPED,\\\"${ZOOKEEPER_SERVERS_ARRAY[index]}\\\""
    done
    ZOOKEEPER_SERVERS_ESCAPED=[${ZOOKEEPER_SERVERS_ESCAPED:1}]
    CMD="$CMD -c storm.zookeeper.servers=$ZOOKEEPER_SERVERS_ESCAPED"
fi

# print and execute command string
echo $CMD
eval $CMD
