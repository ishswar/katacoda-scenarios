
## Install all dependency for gRPC and compile (build) code 

`cd gRPC-maven-helloworld/`{{execute}}

`mvn clean package`{{execute}}

Above command should take around 4~5 min as it collects all the gRPC dependency downlands it and than compiles the code 
at the end you should see success message like this :

```bash
[INFO] Building jar: /root/gRPC-maven-helloworld/target/grpctest-1.0-SNAPSHOT-jar-with-dependencies.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  38.154 s
[INFO] Finished at: 2021-02-23T06:38:26Z
[INFO] ------------------------------------------------------------------------
```

## Output jar file 

You should see in `target` folder now there is jar file that is output of compilation 

`tree target/ -L 1`

In next step we will use `grpctest-1.0-SNAPSHOT-jar-with-dependencies.jar` to run gRPC `Server` and `Client` 