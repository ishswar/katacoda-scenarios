## Pod & Deployment 

### Untaint 

Let's untaint master node to it can run workload 

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{execute}}


