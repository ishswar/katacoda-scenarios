
wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb
sudo dpkg -i bat_0.15.4_amd64.deb

rm -rf bat_0.15.4_amd64.deb

apt-get update && apt-get install -y kubeadm=1.19.0-00
apt-get install -y kubelet=1.19.0-00 kubectl=1.19.0-00
kubeadm config images pull

kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

curl https://docs.projectcalico.org/manifests/canal.yaml -O
kubectl apply -f canal.yaml

wget https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz
tar -zxvf helm-v3.3.4-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

echo "# For TEXT coloring ====" >> ~/.bashrc
echo "export GREEN='\033[0;32m'" >> ~/.bashrc
echo "export RED='\033[0;31m'" >> ~/.bashrc
echo "export YELLOW='\033[1;33m'" >> ~/.bashrc
echo "export CYAN='\033[0;36m'" >> ~/.bashrc
echo "export NC='\033[0m' # No Color" >> ~/.bashrc

#git clone https://github.com/ishswar/k8s-scenarios.git

#ssh node01 apt-get update
## Remove kubeadmin tool from node01 as it causes issue in initail setup
#ssh node01 apt-get purge kubeadm -y
#ssh node01 apt-get install -y kubelet=1.19.0-00 kubectl=1.19.0-00
#ssh node01 kubeadm config images pull
#ssh node01 systemctl stop kubelet
#ssh node01 systemctl disable kubelet
#ssh node01 systemctl status kubelet >> ser.txt
#echo "========" >> ser.text
#ssh node01 systemctl list-unit-files --type=service | grep kubelet >> ser.txt
#
#ssh node01 wget -q https://github.com/etcd-io/etcd/releases/download/v3.4.3/etcd-v3.4.3-linux-amd64.tar.gz
#ssh node01 tar -zxf etcd-v3.4.3-linux-amd64.tar.gz
#ssh node01 sudo cp etcd-v3.4.3-linux-amd64/etcdctl /usr/local/bin
#
#ETCD_CTCL_VERSION=3.4.3
#wget -q https://github.com/etcd-io/etcd/releases/download/v${ETCD_CTCL_VERSION}/etcd-v${ETCD_CTCL_VERSION}-linux-amd64.tar.gz
#tar -zxf etcd-v${ETCD_CTCL_VERSION}-linux-amd64.tar.gz
#cd etcd-v${ETCD_CTCL_VERSION}-linux-amd64
#sudo cp etcdctl /usr/local/bin
