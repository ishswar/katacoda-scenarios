Create cluster 

## Install kind (latest release)

We will create a single master/node kubernetes cluster using kubeadm (version: 1.19)

`./install_kind.sh`{{execute}}

## Create a kind config

`
cat << KINDCONFIG > kind-cluster.conf
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
  extraPortMappings:
  - containerPort: 32070
    hostPort: 32071
- role: worker
  extraPortMappings:
  - containerPort: 32070
    hostPort: 32072
- role: worker
  extraPortMappings:
  - containerPort: 32070
    hostPort: 32073
KINDCONFIG
`{{execute}}

## Create a cluster 

`kind create cluster --config kind-cluster.conf`{{execute}}

## Wait for cluster to be ready 

`
while [ $(kubectl get nodes -o json | grep -i kubeletReady | wc -l) -lt 4 ];  do
  echo "Found $(kubectl get nodes -o json | grep -i kubeletReady | wc -l) in Ready state - expecting 4 to be Ready";
  sleep 5;
done
`{{}}