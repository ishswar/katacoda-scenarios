Populate the cluster

## Remove taint 

As this is single node cluster we need to remove taint from master node 
if we don't do this than no pods can be schedule on master (We are just doing this for demo purpose) 

`kubectl taint node $(hostname) node-role.kubernetes.io/master:NoSchedule-`{{execute}}

## Create pod 

As of now our kubernetes cluster is empty - lets quickly create a simple `nginx` pod 

`kubectl run tester --image=nginx`{{execute}} 

## Enable auditing on API Server 

Lets enable audit tracing on API Server so we can see audit logs that gets generated when users interact with API server 

First copy audit-policy.yaml to it's location 
`cp /root/audit-policy.yaml /etc/kubernetes/audit-policy.yaml`{{execute}}

Second enable Audit on api server - we will just replace api-server pod's static manifest file 
`cp /root/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml`{{execute}}

In few seconds API Server will be restarted and we should see `audit.log` created in **/var/log **
`tail /var/log/audit.log -n 10`{{execute}}

Okay we are all set ...
Next, now lets create a user *john* so he can access cluster and see above pod in default namespace