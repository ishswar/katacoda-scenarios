Learning about gRPC using Java 

Our example is a simple route mapping application that lets clients get information about features on their route, create a summary of their route, and exchange route information such as traffic updates with the server and other clients.

With gRPC we can define our service once in a .proto file and generate clients and servers in any of gRPC’s supported languages, which in turn can be run in environments ranging from servers inside a large data center to your own tablet — all the complexity of communication between different languages and environments is handled for you by gRPC. We also get all the advantages of working with protocol buffers, including efficient serialization, a simple IDL, and easy interface updating.

In this scenario we will perform these steps to learn about gRPC  

1. Setup linux environment with java and maven 
1. Clone sample git Repo with gRPC Hello world 
1. Maven build
1. Run gRPC Hello build - RouteGuide server and RouteGuide client 

More info about this example refer to this link : https://www.grpc.io/docs/languages/java/basics/

By walking through above example you’ll learn how to:

Define a service in a .proto file.
Generate server and client code using the protocol buffer compiler.
Use the Java gRPC API to write a simple client and server for your service.
