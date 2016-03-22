#!/bin/bash

# download storm
wget -q -N http://mirrors.gigenet.com/apache/storm/${STORM_VERSION}/${STORM_VERSION}.zip
unzip -o ${STORM_VERSION}.zip -d .
rm ${STORM_VERSION}.zip

# sudo mv /usr/share/${STORM_VERSION} /usr/share/storm
# sudo ln -s /usr/share/storm /usr/share/${STORM_VERSION}
cd ${STORM_VERSION}

# Now copy config files
cp -a -rv /mnt/storm/. .

# append own hostname to config file
echo "storm.local.hostname: `hostname -i`" | tee -a conf/storm.yaml

exec bin/storm "$@"
