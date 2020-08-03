Time to practice context switching that will be required during CKAD certification 

## Experiment with switching kube context 

As now we have two kube contexts we can try switching around 

### Get all contexts

`kubectl config get-contexts`{{execute}} 

```bash
CURRENT   NAME       CLUSTER    AUTHINFO         NAMESPACE
*         k3d-dk8s   k3d-dk8s   admin@k3d-dk8s
          k3d-k8s    k3d-k8s    admin@k3d-k8s
```

**__*__** means which context is selected (in use) by kubectl 

### Current context 

Get current context `kubectl config current-context`{{execute}}

```bash
master $ kubectl config current-context
k3d-dk8s
``` 

### Switch context 

Switch to _k8s_ context `kubectl config use-context k3d-k8s`{{execute}}

```bash
master $ kubectl config use-context k3d-k8s
Switched to context "k3d-k8s".

master $ kubectl config current-context
k3d-k8s
```

Now if you list nodes we should see 3 nodes (1 master & 2 workers) - `kubectl get nodes -o wide`{{execute}}


```bash
master $ kubectl get nodes -o wide
NAME               STATUS   ROLES    AGE   VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE   KERNEL-VERSION       CONTAINER-RUNTIME
k3d-k8s-server-0   Ready    master   11m   v1.18.6+k3s1   172.19.0.2    <none>        Unknown    4.15.0-109-generic   containerd://1.3.3-k3s2
k3d-k8s-agent-1    Ready    <none>   10m   v1.18.6+k3s1   172.19.0.4    <none>        Unknown    4.15.0-109-generic   containerd://1.3.3-k3s2
k3d-k8s-agent-0    Ready    <none>   11m   v1.18.6+k3s1   172.19.0.3    <none>        Unknown    4.15.0-109-generic   containerd://1.3.3-k3s2
```