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

