Install first K3S cluster in docker using K3d ( also add 2 nodes to this cluster)

## Install k3d cluster with name _k8s_

Once you run below command - k3d will create k3s cluster in docker container with 2 additional nodes as well 
Each of 3 - one master and 2 Nodes will run in it's own docker containers

k3d will also set _kubectl_ context with name _k8s_ for you 

`k3d cluster create k8s -a 2`{{execute}}

## Check if we have k3s cluster now

Once above command finishes successfully if you run `kubectl get nodes`{{execute}}
You should see one master and 2 nodes running in _k8s_ cluster

### Sample output: 
```bash
master $ kubectl get nodes
NAME               STATUS   ROLES    AGE   VERSION
k3d-k8s-agent-1    Ready    <none>   11m   v1.18.6+k3s1
k3d-k8s-server-0   Ready    master   11m   v1.18.6+k3s1
k3d-k8s-agent-0    Ready    <none>   11m   v1.18.6+k3s1
```

## Kubectl context 

Lets check the kubectl context see what do we have so far now 

`kubectl config get-contexts`{{execute}} - it should show only **one** context 'k8s' available and __selected__ 

### Sample output:

```bash
master $ kubectl config get-contexts
CURRENT   NAME      CLUSTER   AUTHINFO        NAMESPACE
*         k3d-k8s   k3d-k8s   admin@k3d-k8s
```

### ~/.kube/config file

You can also checkout the config file for Kubectl that has above info 

`kubectl config view`{{execute}} or you can use *cat* to see it `cat ~/.kube/config`{{execute}}

<details>
  <summary>Click to see sample kubec config</summary>
  
```
master $ kubectl config view

apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://0.0.0.0:46639
  name: k3d-k8s
contexts:
- context:
    cluster: k3d-k8s
    user: admin@k3d-k8s
  name: k3d-k8s
current-context: k3d-k8s
kind: Config
preferences: {}
users:
- name: admin@k3d-k8s
  user:
    password: 65af72f5c1257e08d4c78bc70da7a30a
    username: admin
```
</details>

