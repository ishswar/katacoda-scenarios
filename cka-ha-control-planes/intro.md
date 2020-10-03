
 In this scenario we will see how we can create HA Control plane (masters) nodes in Kubernetes 

At the end of this scenario we will have two Master nodes running on two different machines fronted ended 
by single NGINX load balancer . We should be able to use single API Server URL that we can use 
in kubeconfig . We will test out the fail our as well in action . 

High-level steps that we will perform in this scenario are :

1. Create quick kubernetes **cluster** - One master, with Canal networking) 
1. Create one simple **pod** (just to populate cluster)
1. Create user john's **Private and Public certificates** (kubectl will eventually use these)
1. Get john's public certificates **signed** by Kubernetes Cluster 
1. Add john's certificates to **kubectl**  
1. Create **Role and Role bindings** in cluster so *John* can List,Update and Delete Pods in default namespace 
1. **Test** that everything works as expected 

At he end our setup should look like this : 

![HA Setup in Katacoda](./assets/Kubernetes_HA_Control_plane_setup_on_Katacoda.svg)