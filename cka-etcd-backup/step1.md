Create cluster 

## Create cluster using kubeadm

We will create a single master/node kubernetes cluster using kubeadm 

`kubeadm init --pod-network-cidr=10.244.0.0/16`{{execute}}

Once above command succeeds we got ourselves working cluster 

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

## Wait for CANAL network to be installed 

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

## Install etcdctl tool 

`etcdctl` is command line tool to manage etcd server and it’s date.
We will use this tool to back and restore etcd data

`apt-get install -y etcd-client`{{execute}}

`
RELEASE=$(kubectl exec -it etcd-$(hostname) -n kube-system -- /bin/sh -c 'ETCDCTL_API=3 /usr/local/bin/etcd --version' | head -1 | cut -d":" -f2)
RELEASE=$(echo "$RELEASE" | xargs)
wget https://github.com/etcd-io/etcd/releases/download/v${RELEASE}/etcd-v${RELEASE}-linux-amd64.tar.gz
tar -zxvf etcd-v${RELEASE}-linux-amd64.tar.gz
cd etcd-v${RELEASE}-linux-amd64
sudo cp etcdctl /usr/local/bin
`{{execute}}