Setup kubectl

## Setup kubectl to talk to this cluster

`
mkdir ~/.kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
`{{execute}}

That's about it - here we are assuming you don't have any KUBECONFG 
If you do than you will have to merge the config to use this new cluster

Once above is done we can now connect to cluster and check the status 

`kubectl cluster-info`{{execute}}

### Sample output 

```
Kubernetes master is running at https://127.0.0.1:6443
CoreDNS is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

