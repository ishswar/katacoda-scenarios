Create first master node in cluster 

## Create cluster using kubeadm

We will create first master/node in cluster using kubeadm (version:
1.19)

We will pass **Load balancer** IP and port as input to flag `control-plane-endpoint`

`kubeadm init --control-plane-endpoint "$LB_IP:$LB_PORT" --upload-certs --pod-network-cidr=10.244.0.0/16 || { echo "kubeadm init failed ... need to investigate";}`{{execute}}

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
          echo -e "${GREEN}ALL PODs are up${NC}";
          kubectl get pods -n kube-system --field-selector status.phase=Running
          break;
     else 
          echo "All PODs are not up; waiting";
          echo -e "${YELLOW}Expected $EXPECTED_PODS Pods in kube-system namespace to be running found [$CHECK] running${NC}";
   fi;
   sleep 5;
done`{{execute}}

## Check kube config 

Lets quickly test out kube config to see we are able to connect via LB to AIP server 

`kubectl get nodes -v 6`{{execute}}

You should see kubectl is using load balalncer's URL to connect to API server