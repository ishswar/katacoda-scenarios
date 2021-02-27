
## Install all dependency for gRPC and compile (build) code 

`cd routeguide/`{{execute}}

`mvn clean package`{{execute}}

Above command should take around 4~5 min as it collects all the gRPC dependency downlands it and than compiles the code 
at the end you should see success message like this :

```bash
[WARNING] Configuration options: 'appendAssemblyId' is set to false, and 'classifier' is missing.
Instead of attaching the assembly file: /root/routeguide/target/RouteGuideClient.jar, it will become the file for main project artifact.
NOTE: If multiple descriptors or descriptor-formats are provided for this project, the value of this file will be non-deterministic!
[WARNING] Replacing pre-existing project main-artifact file: /root/routeguide/target/RouteGuideServer.jar
with assembly file: /root/routeguide/target/RouteGuideClient.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  32.779 s
[INFO] Finished at: 2021-02-27T19:27:09Z
[INFO] ------------------------------------------------------------------------
```

## Output jar file 

You should see in `target` folder now there is jar file that is output of compilation 

`tree target/ -L 1`{{execute}}

In next step we will use `RouteGuideServer.jar` to run gRPC `Server` and `RouteGuideClient.jar` to run as `Client` 