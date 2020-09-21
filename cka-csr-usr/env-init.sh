#wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash -
#
#if ( type k3d > /dev/null 2>&1 ) ; then
#  k3d cluster create k8s -a 2;
#  k3d cluster create dk8s -a 1;
#  kubectl config use-context k3d-k8s
#else
#  echo "k3d is not installed can't proceed "; exit 1;
#
#fi
#
#kubectl create ns auditing
#kubectl create ns marketing
#kubectl create cronjob -n auditing doaudits --image=busybox --schedule="*/1 * * * *" -- sleep 4
#kubectl create cronjob -n marketing sendInfo --image=busybox --schedule="*/1 * * * *" -- sleep 2
#kubectl create cronjob -n marketing sendinfo --image=busybox --schedule="*/1 * * * *" -- sleep 2
#sleep 2m
#kubectl -n marketing patch cronjobs.batch sendinfo -p '{"spec":{"suspend":true}}'
#
## Senario 4
#kubectl create deployment deploy-charts --image=nginx:stable-alpine -n auditing

apt-get update && apt-get install -y kubeadm=1.19.0-00
apt-get install -y kubelet=1.19.0-00 kubectl=1.19.0-00