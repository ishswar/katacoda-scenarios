Create first master node in cluster 

## Create sample application

`bat ns.yaml`{{execute}}  
`kubectl apply -f ns.yaml`{{execute}} 


`bat deploy.yaml`{{execute}}  
`kubectl apply -f deploy.yaml`{{execute}} 


`bat service.yaml`{{execute}}  
`kubectl apply -f service.yaml`{{execute}} 

## Deploy first ingress resource

`bat minimal-ingress.yaml`{{execute}}  
`kubectl apply -f minimal-ingress.yaml`{{execute}} 

Let's check how ingress looks like 

`kubectl describe -n test-ing ingresses.networking.k8s.io minimal-ingress`{{execute}}

We can see on ingress path of '/testpath' has been created 

## Update Ingress controller's Node port 

Let's update Ingress controllers main service to listen on wellknown port so we can `curl` to that end-point

`kubectl patch service ng-ingress-release-ingress-nginx-controller -p '{"spec":{"ports":[{"port":80,"nodePort":32702}]}}'`{{execute}}  -n ingress
`kubectl patch service ng-ingress-release-ingress-nginx-controller -p '{"spec":{"ports":[{"port":443,"nodePort":30443}]}}'`{{execute}}  -n ingress

## Test the Ingress 

Moment of truth - if we now curl on URL : `http://0.0.0.0:32702/testpath` we should get 'Hello World' back as that is what our application is suppose to return

`curl -X GET http://0.0.0.0:32702/testpath`{{execute}} 

If you see **Hello world** then **SUCCESS** - we did it 

You can also check that in browser 

[https://[[HOST_SUBDOMAIN]]-32702-[[KATACODA_HOST]].environments.katacoda.com/testpath](https://[[HOST_SUBDOMAIN]]-32702-[[KATACODA_HOST]].environments.katacoda.com/testpath)

