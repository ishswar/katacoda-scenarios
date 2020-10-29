Populate the cluster

Now that we have cluster ready let's play around.

# Test externalTrafficPolicy: Local

Let's test out how externalTrafficPolicy: Local affects NodePort service
and how it forces to use local end-points 

We will deploy one simple NGINX Deployment that when invoked will reply
with information about what Pod and what Node (name) its running on .

We will taint Node 1 with taint that our deployment/pods don't tolerate
thus - no pods will be scheduled on Node 1 .

Then we will deploy 2 replicas of this deployment and expose this
deployment using NodeType service. 

Now due to nature of NodeType port - you can hit on port 32070 on any of
the pods and you should get reply . This is one of the promises of
NodeType service. But since we have added `externalTrafficPolicy` to
`Local` NodePort service running on (IPTables) Node 1 will look for
local pod to forward traffic/packets to - but will will not find it and
we should get Error 

## Create simple NGINX deployment and service

Let's create a simple NGINX base deployment with 2 replicas and expose deployment with service running on port *32070*

`kubectl apply -f deploy.yaml -f service.yaml`{{execute}} 

### If you want to see the YAML for Deployment and Service use below command to see view them 

Deployment :  

`bat deploy.yaml`{{execute}}

Service : 

`bat service.yaml`{{execute}}

### Wait for all pods to be up 

`kubectl get deployments.apps test`{{execute}}

Make sure above output shows 2 Pods are available

## Hit each service on it's HostPort 

`curl --max-time 4 http://0.0.0.0:32072`{{execute}}

`curl --max-time 4 http://0.0.0.0:32073`{{execute}}

`curl --max-time 4 http://0.0.0.0:32071`{{execute}}