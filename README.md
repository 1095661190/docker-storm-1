# docker-storm

The Docker image launches Apache Storm. By default, the `storm.local.hostname` property is set already, but you have to provide all other arguments that you would normally provide.

## No need for a `storm.yaml`!

Storm allows you to provide any property via command line arguments like so:

	bin/storm ui \
        -c nimbus.host=nimbus
You are not restricted to strings, but can also provide integer lists, e.g. here:

	bin/storm supervisor \
        -c supervisor.slots.ports=6700,6701
Or list of strings, e.g. here:

	bin/storm supervisor \
        -c storm.zookeeper.servers="[\"zk1\",\"zk2\",\"zk3\"]"



### Providing ZooKeeper the easy way

This image also lets you specify the ZooKeeper servers with a simple list (e.g. `"zk1,zk2,zk3"`).  
So if your ZooKeeper cluster is made up of `zk1`, `zk2` and `zk3`, you can tell Storm to use this cluster by providing an environment variable:

	-e STORM_ZOOKEEPER_SERVERS="zk1,zk2,zk3"

Internally, this is translated to 

	-c storm.zookeeper.servers="[\"zk1\",\"zk2\",\"zk3\"]"

So here is the Storm-native way:  

	docker run \
	    baqend/storm nimbus \
	      -c nimbus.host=nimbus \
          -c storm.zookeeper.servers="[\"zk1\",\"zk2\",\"zk3\"]"

And here the simple alternative:

	docker run \
	    -e STORM_ZOOKEEPER_SERVERS="zk1,zk2,zk3" \
	    baqend/storm nimbus \
	      -c nimbus.host=nimbus 