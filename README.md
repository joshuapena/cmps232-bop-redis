Run the following commands to install redis in the box-of-pain directory:

```
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
```

Run the following scripts from the box-of-pain directory.

First run start_cluster.sh.
This will create six nodes. Three primary and three secondary.
An output like the following will show up:
```
M: b3da90dd678ada53710cc2a3910b93deb2d2097a 127.0.0.1:7001
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
S: c98195e3d4424c0fa3c89b0fc7aeedd5d462ff6b 127.0.0.1:7004
   slots: (0 slots) slave
   replicates 0fd15855e7ea21ba47c4a5220f7dcbadb2eaf227
M: 7471ad0d3ca949ea5fa305e5fedbd36ff2c66a3e 127.0.0.1:7003
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
S: 29ef034dbbdaaa05c4ddd654a67042c57a1eedfb 127.0.0.1:7005
   slots: (0 slots) slave
   replicates 7471ad0d3ca949ea5fa305e5fedbd36ff2c66a3e
M: 0fd15855e7ea21ba47c4a5220f7dcbadb2eaf227 127.0.0.1:7002
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
S: 31fb7db29e2c6f1c7a43fcd3a34dff891dc89a45 127.0.0.1:7006
   slots: (0 slots) slave
   replicates b3da90dd678ada53710cc2a3910b93deb2d2097a
```

Next run ```primary_test_single.sh 30001``` and look at the pdf file.
Either the values were written to the node 30001 or a different one. If it was written to a different one, it will be shown in the trace as the port changes halfway through the calls.

Find the primary and the secondary for the proper writes. For example if the writes were done to port 7002 in the configuration above, the corresponding secondary would be 7004.

In two windows run the following commands:
Window 1) Run ```secondary_test.sh <port> single``` to start the monitoring of the secondary.
Window 2) Run ```primary_test_single.sh``` to run the test.
Stop window 1.

This will have the output in pdf form of a single insert into the cluster.

In two windows run the following commands:
Window 1) Run ```secondary_test.sh <port> multiple``` to start the monitoring of the secondary.
Window 2) Run ```primary_test_multiple.sh``` to run the test.
Stop window 1.

This will have the output in pdf form of a multiple inserts into the cluster.

Finally run ```./stop_cluster.sh``` to stop the redis cluster.

In the output, there were multiple examples of the following two system calls in the multiple writes and only one for the single write:
```
13157:entry:read:127.0.0.1:53722->127.0.0.1:7005:
13157:exit:read:127.0.0.1:53722->127.0.0.1:7005:31
```

There is a strong belief this is where the primary is getting the read and replicating to the secondary. I was not sure how inject faults, but if I could this location would be the place to try for the primary.
