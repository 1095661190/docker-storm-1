#!/bin/bash

# now let's build the command to start storm
CMD="exec bin/storm \"\$@\" -c storm.local.hostname=\$(hostname -i | awk '{print \$1;}')"

############################
# storm.zookeeper.servers #
############################
if ! [ -z "$STORM_ZOOKEEPER_SERVERS" ]; then
    # All ZooKeeper server IPs in an array
    IFS=', ' read -r -a ZOOKEEPER_SERVERS_ARRAY <<< "$STORM_ZOOKEEPER_SERVERS"
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
