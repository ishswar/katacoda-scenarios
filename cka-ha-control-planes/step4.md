Use kubectl tool to test configuration

# Check to see we have two masters now 

From first master server we run simple `kubectl get nodes` command to see now we have two masters in cluster 

`
NUMBER_READY_NODES=$(kubectl get nodes -o jsonpath='{range .items[*]}{range .status.conditions[?(@.type=="Ready")]}{.reason}{"\n"}{end}{end}' | grep "KubeletReady" | wc -l)
if [ "$NUMBER_READY_NODES" -eq 2 ]; then
  echo "SUCCESS - we now have $NO_READY_NODES master nodes"
  kubectl get nodes
fi
`{{execute}}

# Populate the cluster

For testing we need to populate cluster with some pods/deployments - lets to that first

## Remove taints 

As we have two master nodes - in general we are not suppose to run any workload on these masters 
But since we don't have more than two machines we are going to remove taints from these two masters so we can run some workload on these two nodes

`
kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-
kubectl taint node node01 node-role.kubernetes.io/master:NoSchedule-
`{{execute}}

## Run 6 instance of *busybox* deployment 

`
kubectl create deployment test --image=busybox -- sleep 3600
kubectl scale deployment test --replicas=6
`{{execute}}
