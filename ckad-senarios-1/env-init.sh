echo "Welcome to k3s/k3d multi cluster setup senario"

#echo "Getting k3d CLI"

wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash -

if ( type k3d > /dev/null 2>&1 ) ; then
  k3d cluster create k8s -a 2;
  k3d cluster create dk8s -a 1;
  kubectl config use-context k3d-k8s
else
  echo "k3d is not installed can't proceed "; exit 1;

fi