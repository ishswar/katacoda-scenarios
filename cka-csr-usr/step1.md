Create cluster 

## Create cluster using kubeadm

We will create a single master/node kubernetes cluster using kubeadm (version: 1.19)

`kubeadm init --pod-network-cidr=10.244.0.0/16`{{execute}}

Once above command succeeds we got ourselves working cluster 

Lets setup kubeconfig so we can run kubectl and interact with cluster 
`
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
`{{execute}}

## Install network 

As of now cluster is not ready (master node) - because it is waiting network to be add to cluster
Lets installed [Canal](https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel) network to cluster 

`
curl https://docs.projectcalico.org/manifests/canal.yaml -O
kubectl apply -f canal.yaml
`{{execute}}

