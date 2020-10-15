
Test Fault tolerance (HA)

# Stop one of the master node 

As kublet (is node) that controls node and is running as linux service - we can just stop this service 

`
systemctl stop kubelet
`{{execute}}

This should stop node on server `controlplane` - we can confirm that uisng kubectl 

Lets wait till node on `controlplane` goes down 
`
SECONDS=0
while : ;
 do
  if [ $(kubectl get nodes $(hostname) -o jsonpath='{range .status.conditions[?(@.type=="Ready")]}{.reason}{end}') != "NodeStatusUnknown" ]; then
  echo "Node/kubelet on Host $(hostname) is still running ... waited $SECONDS(seconds)";
  sleep 5;
  if [ $SECONDS -gt 180 ]; then
     echo "Waited $SECONDS - will exit now - this needs to be invastigated"
     break;
  fi
  elif [ $(kubectl get nodes $(hostname) -o jsonpath='{range .status.conditions[?(@.type=="Ready")]}{.reason}{end}') = "NodeStatusUnknown" ]; then
    echo "Node/kubelet is posted Not Ready - it has gone down now"
    break;
  fi
 done
`{{execute}}

Now if you run below command 

`
kubectl get nodes -o wide
`{{execute}}

We can see node on `controlplane` is in **NotReady** state 

Fact that we got this reply ***proves*** that HA worked - as API server on 'controlplane' is ***gone*** so NGINX forwarded 
request to second server in list that is 'node01' and it responded to `kubectl` request 

# Why Pods on stopped master node is still running 

If you run command 

`
kubectl get pods
`{{execute}}

You will see they are still running - they are not evicted or terminated - this is because
scheduler waite 5 (300 seconds) before evicting or terminating pod in case of node is not reachable 

We can see this limit from output of describe POD

`
ONE_POD_ID=$(kubectl get pods -o jsonpath="{.items[0].metadata.name}")
kubectl get pod $ONE_POD_ID -o jsonpath="{.spec.tolerations[?(@.key=='node.kubernetes.io/unreachable')]}" | jq .
`{{execute}}

So , if you wait 5 min after stopping first master node you will see pods running on '*controlplane*' are 
terminated and new one are created on other working node 