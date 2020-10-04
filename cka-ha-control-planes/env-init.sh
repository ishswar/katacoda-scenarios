
wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb
sudo dpkg -i bat_0.15.4_amd64.deb

rm -rf bat_0.15.4_amd64.deb

apt-get update && apt-get install -y kubeadm=1.19.0-00
apt-get install -y kubelet=1.19.0-00 kubectl=1.19.0-00
kubeadm config images pull

#git clone https://github.com/ishswar/k8s-scenarios.git

ssh node01 apt-get update
ssh node01 apt-get install -y kubeadm=1.19.0-00
ssh node01 apt-get install -y kubelet=1.19.0-00 kubectl=1.19.0-00
ssh node01 kubeadm config images pull
ssh node01 systemctl stop kubelet
ssh node01 systemctl disable kubelet
ssh node01 systemctl status kubelet >> ser.txt
echo "========" >> ser.text
ssh node01 systemctl list-unit-files --type=service | grep kubelet >> ser.txt

ETCD_CTCL_VERSION=3.4.3
wget -q https://github.com/etcd-io/etcd/releases/download/v${ETCD_CTCL_VERSION}/etcd-v${ETCD_CTCL_VERSION}-linux-amd64.tar.gz
tar -zxf etcd-v${ETCD_CTCL_VERSION}-linux-amd64.tar.gz
cd etcd-v${ETCD_CTCL_VERSION}-linux-amd64
sudo cp etcdctl /usr/local/bin

echo "# For TEXT coloring ====" >> ~/.bashrc
echo "export GREEN='\033[0;32m'" >> ~/.bashrc
echo "export RED='\033[0;31m'" >> ~/.bashrc
echo "export YELLOW='\033[1;33m'" >> ~/.bashrc
echo "export CYAN='\033[0;36m'" >> ~/.bashrc
echo "export NC='\033[0m' # No Color" >> ~/.bashrc