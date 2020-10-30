kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI.

In this scenario we will perform these steps 

1. Install ** [kind](https://kind.sigs.k8s.io/) **
2. Using * [kind configuration](https://kind.sigs.k8s.io/docs/user/configuration/) * file create a cluster ( 1 master node and 3
   worker nodes )
3. Check-out the cluster - see how cluster looks like 

(Optionally) 

We will play with few of kubernetes topics :

1. Deployment with ***sidecar*** container (Main : NGINX , SideCar : BUSYBOX - builds
   index.html file)
1. How using ***downward*** API we can expose some of the information to POD such as POD's IP 
   and name of Node this pod is running on     
2. Add ***taint*** to one of the nodes so all deployments get scheduled to
   other two nodes.
1. Expose deployment over *NodePort* - but use `externalTrafficPolicy:
  Local` to see it's impact on routing of request to pod in cluster
1. Will check IPTables entries (using ***exec***) in *kube-proxy* pod on to see what
  impact/effect `externalTrafficPolicy: Local` has on IPTables.
1. How we can select pod based on Node name (***field-selector***) and and ***label selector*** 
1. How we can ***patch*** existing kubernetes resources using kubectl.

# Cluster overview

At the end we will have cluster like this 

![](./assets/KIND-1-small.png)
