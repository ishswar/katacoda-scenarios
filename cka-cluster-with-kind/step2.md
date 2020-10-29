Populate the cluster

## Create simple NGINX deployment and service

`kubectl apply -f deploy.yaml -f service.yaml`{{execute}} 

## Hit each service on it's Host Port 

`wget -O- http://0.0.0.0:32071`{{execute}}

`wget -O- http://0.0.0.0:32072`{{execute}}

`wget -O- http://0.0.0.0:32073`{{execute}}
