Create a backup

## Create certificate for John

`openssl genrsa -out john.key 2048`{{execute}}

`etcdctl` is command line tool to manage etcd server and it’s date.
We will use this tool to back and restore etcd data


`
ETCD_CTCL_VERSION=3.4.3
wget -q https://github.com/etcd-io/etcd/releases/download/v${ETCD_CTCL_VERSION}/etcd-v${ETCD_CTCL_VERSION}-linux-amd64.tar.gz
tar -zxf etcd-v${ETCD_CTCL_VERSION}-linux-amd64.tar.gz
cd etcd-v${ETCD_CTCL_VERSION}-linux-amd64
sudo cp etcdctl /usr/local/bin
`{{execute}}

## etcdctl connection parameters

`etcdctl` is command line tool to manage etcd server and it’s date.
Before we create a etcd backup we need to connect to running etcd server; as in case of kubernetes it is secured endpoint.
We need to know it's connection parameters.

** NOTE : this restore process is for a locally hosted etcd running in a static pod. **

We can find that using etcd pod's static manifest 

`cat /etc/kubernetes/manifests/etcd.yaml`{{execute}}

From above file we need 4 things :

1. etcd endpoint(s)
1. CA Certs file 
1. Server certificate 
1. Server certificate key

## Check connectivity 

Verify we're connecting to the right cluster...define your endpoints and keys

`
CACERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-trusted-ca-file | cut -d= -f2)
SERVER_KEY=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-key-file | cut -d= -f2)
SERVER_CERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-cert-file | cut -d= -f2)
ENDPOINTS=$(cat /etc/kubernetes/manifests/etcd.yaml | grep advertise-client-urls= | cut -d= -f2)
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINTS --write-out=table --cacert $CACERT --cert $SERVER_CERT --key $SERVER_KEY \
   member list
`{{execute}}

## Take a backup 

Lets take a backup - we are saving backup named 'snapshot.db' in current directory 

`
CACERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-trusted-ca-file | cut -d= -f2)
SERVER_KEY=$(cat /etc/kubernetes/manifests/etcd.yaml | grep "\-\-key-file" | cut -d= -f2)
SERVER_CERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep "\-\-cert-file" | cut -d= -f2)
ENDPOINTS=$(cat /etc/kubernetes/manifests/etcd.yaml | grep advertise-client-urls= | cut -d= -f2)
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINTS snapshot save snapshot.db --cacert $CACERT --cert $SERVER_CERT --key $SERVER_KEY
`{{execute}}

## Check a backup (We need to make sure backup is good)

Read the metadata from the backup/snapshot to print out the snapshot's status 

`ETCDCTL_API=3 etcdctl --write-out=table snapshot status snapshot.db`{{execute}}