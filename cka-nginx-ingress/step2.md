Create first master node in cluster 

## Create sample application

`cat ns.yaml`{{execute}}
`kubectl apply -f ns.yaml`{{execute}} 


`cat deploy.yaml`{{execute}}
`kubectl apply -f deploy.yaml`{{execute}} 


`cat service.yaml`{{execute}}
`kubectl apply -f service.yaml`{{execute}} 

## Deploy first ingress resource

`cat minimal-ingress.yaml`{{execute}}
`kubectl apply -f minimal-ingress.yaml`{{execute}} 

## Update Ingress controller's Node port 


`kubectl patch service ng-ingress-release-ingress-nginx-controller -p '{"spec":{"ports":[{"port":80,"nodePort":32702}]}}'`{{execute}}

