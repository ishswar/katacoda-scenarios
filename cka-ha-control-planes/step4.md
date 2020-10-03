Test Fault tolerance (HA)

# Stop one of the master node 

As kublet (is node) that controls node and is running as linux service - we can just stop this service 

`
systemctl stop kubelet
`{{execute}}

This should stop node on server 'controlplane' - we can confirm that uisng kubectl 

`
kubectl get nodes -o wide
`{{execute}}

We can see node on 'controlplane' is in **NotReady** state 

Fact that we got this reply ***proves*** that HA worked - as API server on 'controlplane' is gone so NGINX forwarded 
request to second server in list 'node01' and it responded to `kubectl` request 

# PODS on stopped master is still running 

If you run command 

`
kubectl get pods
`{{execute}}

You will see they are still running - they are not evicted or terminated - this is because
scheduler waites 5 (300 seconds) before evicting or terminatating pod in case of node is not reachable 

We can see this limit from output of describe POD

`kubectl get pod test-5f6778868d-jlbd2 -o jsonpath="{.spec.tolerations[?(@.key=='node.kubernetes.io/unreachable')]}" | jq .
kubectl get pods -o jsonpath="{.items[0].metadata.name}"`{{execute}}

So , if you wait 5 min after stopping first master node you will see pods running on 'controlplane' are 
terminated and new one are created on other working node 