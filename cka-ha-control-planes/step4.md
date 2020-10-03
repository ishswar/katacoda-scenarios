Test Fault tolerance (HA)

# Stop one of the master node 

As kublet (is node) controls node and is running as linux service - we can just stop this service 

`
systemctl stop kubelet
`

This should stop node on server 'controlplane' - we can confirm that uisng kubectl 

`
kubectl get nodes -o wide
`

We can see node on 'controlplane' is in NotReady state 



`kubectl get pod test-5f6778868d-jlbd2 -o jsonpath="{.spec.tolerations[?(@.key=='node.kubernetes.io/unreachable')]}" | jq .
kubectl get pods -o jsonpath="{.items[0].metadata.name}"`