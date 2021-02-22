
mkdir backup
cp -rfp /etc/kubernetes/pki/ca.* backup/
ls -la backup/
kubectl run forgetmenot --image=nginx
kubectl get pods

CACERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-trusted-ca-file | cut -d= -f2)
SERVER_KEY=$(cat /etc/kubernetes/manifests/etcd.yaml | grep "\-\-key-file" | cut -d= -f2)
SERVER_CERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep "\-\-cert-file" | cut -d= -f2)
ENDPOINTS=$(cat /etc/kubernetes/manifests/etcd.yaml | grep advertise-client-urls= | cut -d= -f2)
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINTS snapshot save backup/snapshot.db --cacert $CACERT --cert $SERVER_CERT --key $SERVER_KEY

tree backup/ 

kubeadm reset --force

ETCDCTL_API=3 etcdctl snapshot restore backup/snapshot.db
ls
mkdir -p /etc/kubernetes/pki/

cp -rfp backup/ca.* /etc/kubernetes/pki/
ls -la /etc/kubernetes/pki/
mv default.etcd/member/ /var/lib/etcd/
ls -la /var/lib/etcd/

kubeadm init --ignore-preflight-errors=DirAvailable--var-lib-etcd --v=5

  rm -rf $HOME/.kube
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  
   60  ls -la /etc/kubernetes/pki/
   61  history