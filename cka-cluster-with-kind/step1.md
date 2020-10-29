Create cluster 

## Install kind (latest release)

First lets install latest version of Kind - so we can use it to create kubernetes cluster

`./install_kind.sh`{{execute}}

## Create a kind config

We will use below kind config 

`bat kind-cluster.conf`{{execute}}

## Create a cluster 

This will create one control plane (Master) Node and 3 worker Nodes

`kind create cluster --config kind-cluster.conf`{{execute}}

## Wait for cluster to be ready 

`
while [ $(kubectl get nodes -o json | grep -i kubeletReady | wc -l) -lt 4 ];  do
  echo "Found $(kubectl get nodes -o json | grep -i kubeletReady | wc -l) in Ready state - expecting 4 to be Ready";
  sleep 5;
done
`{{execute}}