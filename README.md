# docker-storm

We created this image to ease deployment of Apache Storm. 


The Docker image launches Apache Storm. By default, the `storm.local.hostname` property is set already, but you have to provide all other arguments that you would normally provide.

## No need for a `storm.yaml`!

Storm allows you to provide any property via command line arguments like this:

	bin/storm ui \
        -c nimbus.host=nimbus
You are not restricted to strings, but can also provide integer lists:

	bin/storm supervisor \
        -c supervisor.slots.ports=[6700,6701]
Or lists of strings:

	bin/storm supervisor \
        -c storm.zookeeper.servers="[\"zk1\",\"zk2\",\"zk3\"]"

You can look up [**all the parameters in the source code**](https://github.com/apache/storm/blob/0.9.3-branch/storm-core/src/jvm/backtype/storm/Config.java).


### Providing ZooKeeper the easy way

This image also lets you specify the ZooKeeper servers with a simple list (e.g. `"zk1,zk2,zk3"`) instead of the more verbose format Storm requires (e.g. `"[\"zk1\",\"zk2\",\"zk3\"]"`). 
So if your ZooKeeper cluster is made up of `zk1`, `zk2` and `zk3`, you can tell Storm to use this cluster by providing the following environment variable:

	-e STORM_ZOOKEEPER_SERVERS="zk1,zk2,zk3"

Internally, this is translated to 

	-c storm.zookeeper.servers="[\"zk1\",\"zk2\",\"zk3\"]"

So to be clear, here is a direct comparison between both (equivalent) variants. First, here is the Storm-native way:  

	docker run \
	    baqend/storm nimbus \
	      -c nimbus.host=nimbus \
          -c storm.zookeeper.servers="[\"zk1\",\"zk2\",\"zk3\"]"

And here the simple alternative:

	docker run \
	    -e STORM_ZOOKEEPER_SERVERS="zk1,zk2,zk3" \
	    baqend/storm nimbus \
	      -c nimbus.host=nimbus



For an example of how we use this image, also see our [tutorial on how to use Storm with Docker Swarm](https://github.com/Baqend/tutorial-swarm-storm).

## Build Process

All build parameters are provided in file `params.sh`. The following command builds and pushes the image with all versions provided in the final: 

	. allVersions.sh build push 
(This is basically just a reminder for us and not interesting for most of you ;-) )