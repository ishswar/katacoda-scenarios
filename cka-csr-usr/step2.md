Populate the cluster

## Remove taint 

As this is single node cluster we need to remove tain from master node 
if we don't do this than no pods can be secude on master (We are just doing this for demo purpose) 

`kubectl taint node $(hostname) node-role.kubernetes.io/master:NoSchedule-`{{execute}}

## Create pod 

As of now our kubernetes cluster is empty - lets quickly create a simple `nginx` pod 

`kubectl run tester --image=nginx`{{execute}} 

Next, now lets create a user user *john* so he can access cluster and see above pod