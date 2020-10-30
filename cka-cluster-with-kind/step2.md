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

Just for simply city we will make sure that pods get scheduled on node ``
and `` - so lets taint node `` 

`kubectl taint node kind-worker no:testpod:NoSchedule`{{execute}}

Now we apply below to YAMLs that will create deployment and service

`kubectl apply -f deploy.yaml -f service.yaml`{{execute}} 

### (Optional) If you want to see the YAML for Deployment and Service use below command to see view them 

Deployment :  

If you see closely this deployment uses **sidecar** container to populate
NGINX's default *index.html* with text that has Pod's Name and Node's name
so when we hit any of these NGINX server we know which Pod we hit and
it's running on what Node . 

`bat deploy.yaml`{{execute}}

Service : 

`bat service.yaml`{{execute}}

### Wait for all pods to be up 

`kubectl get deployments.apps test`{{execute}}

Make sure above output shows 2 Pods are available

## Hit each service on it's HostPort 

As node kind-worker` has taint on it - we are sure pods will be only
running/scheduled on `` and `` and let's hit their NodePort and we should
get reply 

`curl --max-time 4 http://0.0.0.0:32072`{{execute}}

`curl --max-time 4 http://0.0.0.0:32073`{{execute}}

** **NOTE** ** : Now you might think why are we not hitting on 

`curl --max-time 4 http://0.0.0.0:32071`{{execute}}