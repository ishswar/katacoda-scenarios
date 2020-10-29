Create cluster 

## Install kind (latest release)

We will create a single master/node kubernetes cluster using kubeadm (version: 1.19)

`./install_kind.sh`{{execute}}

## Create a kind config

`
cat << KINDCONFIG > kind-cluster.conf
# a cluster with 3 control-plane nodes and 3 workers
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: control-plane
- role: control-plane
- role: worker
- role: worker
- role: worker
KINDCONFIG
`{{execute}}

## Create a cluster 

`kind create cluster --config kind-cluster.conf`{{execute}}