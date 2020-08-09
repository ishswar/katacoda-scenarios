Check the cluster


## k3s / k3d based cluster 

We are using lightweight K3S based kubernetes clusters .
These clusters will be running inside docker containers for that we are using k3d CLI tools .

`kubectl get nodes`{{execute}}

Output should look like this :

```bash
master $ kubectl get nodes
NAME               STATUS   ROLES    AGE   VERSION
k3d-k8s-agent-1    Ready    <none>   11m   v1.18.6+k3s1
k3d-k8s-server-0   Ready    master   11m   v1.18.6+k3s1
k3d-k8s-agent-0    Ready    <none>   11m   v1.18.6+k3s1
```

## Multiple clusters / Multiple contexts 

Keep in mind each scenarios will be needing to perform in given kubernetes cluster  
Only thing you need to do is swith the context using command given in scenario

## Good time to setup ~/.bashrc file 

If you need to setup your bash session for any tooling related 
settings this is good time to do - including kubectl auto completion  