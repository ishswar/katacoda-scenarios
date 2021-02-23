
## Runt the code 

In this step we will start gRPC server that will be listening on TCP port 50051; in other terminal we will start 
gRPC Client that will send request on port 50051 to server and server should respond back with 'Hello'

### Run Server
 
`java -cp target/grpctest-1.0-SNAPSHOT-jar-with-dependencies.jar org.jpdna.grpchello.HelloWorldServer`{{execute}}

Output should look like this 

```bash
Feb 23, 2021 6:50:48 AM org.jpdna.grpchello.HelloWorldServer start
INFO: Server started, listening on 50051
```

### Run client 

`cd gRPC-maven-helloworld/`{{execute}}

`java -cp target/grpctest-1.0-SNAPSHOT-jar-with-dependencies.jar org.jpdna.grpchello.HelloWorldClient TIBCO`{{execute}}

Output should look like this if server responded

```bash
Feb 23, 2021 6:53:12 AM org.jpdna.grpchello.HelloWorldClient greet
INFO: Will try to greet world ...
Feb 23, 2021 6:53:13 AM org.jpdna.grpchello.HelloWorldClient greet
INFO: Greeting: Hello world
```