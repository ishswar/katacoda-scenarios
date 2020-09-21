
In this scenario we will see how we can create a Normal user for Kubernetes cluster 

At the end of the this scenario we will have a user named `john` who can authenticate himself against cluster and should be able 
to List,Update and Delete Pods in `default` namespace

High-level steps that we will perform in this scenario are :

1. Create quick kubernetes **cluster** - One master, with Canal networking) 
1. Create one simple **pod** (just to populate cluster)
1. Create user john's **Private and Public certificates** (kubectl will eventually use these)
1. Get john's public certificates **signed** by Kubernetes Cluster 
1. Add john's certificates to **kubectl**  
1. Create **Role and Role bindings** in cluster so John can List,Update and Delete Pods in default namespace 
1. **Test** that everything works as expected 
