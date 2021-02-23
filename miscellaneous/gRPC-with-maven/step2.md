# Step 2
## Clone git Repo

`git clone https://github.com/jpdna/gRPC-maven-helloworld.git`{{execute}}

### See the directory structure of git repo 

`tree gRPC-maven-helloworld/`{{execute}}

Sample output : 

```bash
>> tree gRPC-maven-helloworld/
gRPC-maven-helloworld/
├── pom.xml
├── README.md
└── src
    ├── main
    │   ├── java
    │   │   └── org
    │   │       └── jpdna
    │   │           └── grpchello
    │   │               ├── HelloWorldClient.java
    │   │               ├── HelloWorldClient.java~
    │   │               ├── HelloWorldServer.java
    │   │               ├── HelloWorldServer.java~
    │   │               └── old_App.java.old
    │   └── proto
    │       └── hello_world.proto
    └── test
        └── java
            └── org
                └── jpdna
                    └── grpchello
                        └── AppTest.java

12 directories, 9 files
```

