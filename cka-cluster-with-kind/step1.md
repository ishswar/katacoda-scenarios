Create cluster 

## Install kind (latest release)

First lets install latest version of Kind - so we can use it to create kubernetes cluster

`./install_kind.sh`{{execute}}

## Create a kind config

We will use below kind config 

`bat kind-cluster.yaml`{{execute}}

## Create a cluster 

This will create 1 control plane (Master) Node and 3 worker Nodes

`kind create cluster --config kind-cluster.yaml`{{execute}}

## Wait for cluster to be ready 

Let's wait for all Nodes in cluster to post ***Ready*** status before we
continue

`
while true; do
  READY_COUNT=$(kubectl get nodes -o json | grep -i kubeletReady | wc -l)  if [ $READY_COUNT -eq 4 ]; then
   {
     echo "All nodes are posting ready"
     kubectl get nodes -o wide
     break;
   }
  else {
  echo "Found $(kubectl get nodes -o json | grep -i kubeletReady | wc -l) in Ready state - expecting 4 to be Ready";
  sleep 5;
   }
  fi
  done `{{execute}}