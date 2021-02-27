# Step 2
## Clone git Repo

`https://github.com/zhqu-tibco/routeguide.git`{{execute}}

Output should look like this : 

```bash
Cloning into 'routeguide'...
remote: Enumerating objects: 72, done.
remote: Counting objects: 100% (72/72), done.
remote: Compressing objects: 100% (45/45), done.
remote: Total 72 (delta 11), reused 63 (delta 9), pack-reused 0
Unpacking objects: 100% (72/72), done.
```
### See the directory structure of git repo 

`tree routeguide/`{{execute}}

Sample output : 

```bash
>> tree routeguide/
routeguide/
├── pom.xml
├── README.md
└── src
    ├── main
    │   ├── java
    │   │   └── io
    │   │       └── grpc
    │   │           └── examples
    │   │               └── routeguide
    │   │                   ├── RouteGuideClient.java
    │   │                   ├── RouteGuideServer.java
    │   │                   └── RouteGuideUtil.java
    │   ├── proto
    │   │   └── route_guide.proto
    │   └── resources
    │       └── io
    │           └── grpc
    │               └── examples
    │                   └── routeguide
    │                       └── route_guide_db.json
    └── test
        └── java
            └── io
                └── grpc
                    └── examples
                        └── routeguide
                            ├── RouteGuideClientTest.java
                            └── RouteGuideServerTest.java

19 directories, 9 files
```

