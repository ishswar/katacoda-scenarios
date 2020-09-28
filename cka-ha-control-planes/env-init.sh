
wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb
sudo dpkg -i bat_0.15.4_amd64.deb

rm -rf bat_0.15.4_amd64.deb

apt-get update && apt-get install -y kubeadm=1.19.0-00
apt-get install -y kubelet=1.19.0-00 kubectl=1.19.0-00
kubeadm config images pull

ssh node01 apt-get update
ssh node01 apt-get install -y kubeadm=1.19.0-00
ssh node01 apt-get install -y kubelet=1.19.0-00 kubectl=1.19.0-00
ssh node01 kubeadm config images pull

git clone https://github.com/ishswar/k8s-scenarios.git