Create cluster 

# Kubernetes cluster

We already we got ourselves a Kubernetes cluster of version 1.19.x , let's check that

`
kubectl get nodes
`{{execute}}


## Install NGINX Ingress controller

Let's install ingress controller based on NGINX 
We will use Helm 3 to install it , we will deploy NGINX Ingress controller in `ingress` namespace 

`
kubectl create ns ingress
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ng-ingress-release ingress-nginx/ingress-nginx -n ingress
`{{execute}}

