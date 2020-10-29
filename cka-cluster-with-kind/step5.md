Restore from backup 

## Restore etcd data back from backup 

First we back up existing data (we never know we might need this)

`
DATA_DIR=$(cat /etc/kubernetes/manifests/etcd.yaml | grep data-dir | cut -d= -f2)
mv $DATA_DIR $DATA_DIR.old`{{execute}}

Restore data locally 

`ETCDCTL_API=3 etcdctl snapshot restore snapshot.db`{{execute}}

Stop the etcd container and move the back quickly 

`
DATA_DIR=$(cat /etc/kubernetes/manifests/etcd.yaml | grep data-dir | cut -d= -f2)
echo "etcd data directory is $DATA_DIR"
docker stop $(docker ps | grep etcd | cut -d" " -f1) ;
mkdir -p $DATA_DIR 
cp -rf ./default.etcd/* $DATA_DIR
`{{execute}}


## etcd pod must has been restarted 

In above stop we stop the etcd container - `kubelet` would have detected that and must have restarted etcd pod 
We can check this by looking at RESTART count on pod 

`kubectl get pod -n kube-system etcd-$(hostname)`{{execute}}

Sample output should show like this 

```bash
master $ 
NAME                READY   STATUS    RESTARTS   AGE
etcd-controlplane   1/1     Running   2          12m
``` 

## Check new Pod (that was created backup was taken) is gone 

`kubectl get pods`{{execute}} 

Above command should only show one pod running in cluster - if you see that then restore is ***SUCCESS***
