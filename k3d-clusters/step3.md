Install first K3S cluster in docker using K3d ( also add 2 nodes to this cluster)

## Install k3d cluster with name _dk8s_

All steps are almost same as previous steps - in this case wea re going to create a cluster _dk8s_ with 1 node.
Once you run below command - k3d will create k3s cluster in docker container with 2 additional nodes as well 
Each of 2 - one master and 1 Nodes will run in it's own docker containers

k3d will also set _kubectl_ context with name _k8s_ for you 

`k3d cluster create dk8s -a 1`{{execute}}

__**AT THE END K3D WILL SWITCH KUB (kubectl) CONTEXT TO dk8s**__

## Check if we have second k3s cluster now

Once above command finishes successfully if you run `kubectl get nodes`{{execute}}
You should see one master and 2 nodes running in _k8s_ cluster

### Sample output: 
```bash
master $ kubectl get nodes
NAME                STATUS   ROLES    AGE   VERSION
k3d-dk8s-agent-0    Ready    <none>   44s   v1.18.6+k3s1
k3d-dk8s-server-0   Ready    master   43s   v1.18.6+k3s1
```

## Kubectl context 

Lets check the kubectl context see what do we have so far now 

`kubectl config get-contexts`{{execute}} - it should show two (2) contexts 'k8s' and 'dk8s' available and ***dk8s*** __selected__ 

### Sample output:

```bash
master $ kubectl config get-contexts
CURRENT   NAME       CLUSTER    AUTHINFO         NAMESPACE
*         k3d-dk8s   k3d-dk8s   admin@k3d-dk8s
          k3d-k8s    k3d-k8s    admin@k3d-k8s
```
