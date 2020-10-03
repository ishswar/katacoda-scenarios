Create cluster 

## Create cluster using kubeadm

We will create first master/node in cluster using kubeadm (version:
1.19)

We will pass **Load balancer** IP and port as input to flag `control-plane-endpoint`

`kubeadm init --control-plane-endpoint "$LB_IP:$LB_PORT" --upload-certs --pod-network-cidr=10.244.0.0/16 || { echo "kubeadm init failed ... need to investigated";}`{{execute}}

Once above command succeeds we got ourselves first master node in cluster 

Lets setup kubeconfig so we can run kubectl and interact with cluster 
`
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
`{{execute}}

## Install network 

As of now cluster is not ready (1st master node) - because it is waiting network to be add to cluster
Lets installed [Canal](https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel) network to cluster 

`
curl https://docs.projectcalico.org/manifests/canal.yaml -O
kubectl apply -f canal.yaml
`{{execute}}

### Wait for CANAL network to be installed 

`
EXPECTED_PODS=9
while true;
  do CHECK=$(kubectl get pods -n kube-system --field-selector status.phase=Running --no-headers | wc -l);
   if [ $CHECK -eq $EXPECTED_PODS ];
     then 
          echo "ALL PODs are up";
          kubectl get pods -n kube-system --field-selector status.phase=Running
          break;
     else 
          echo "All PODs are not yet up";
          echo "Expected $EXPECTED_PODS Pods in kube-system namespace to be running found [$CHECK] running"
   fi;
   sleep 5;
done`{{execute}}