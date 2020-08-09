wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash - && k3d cluster create k8s -a 2 && k3d cluster create dk8s -a 1 && kubectl config use-context k3d-k8s
