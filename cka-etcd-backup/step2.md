Populate the cluster

## Remove taint 

As this is single node cluster we need to remove tain from master node 
if we don't do this than no pods can be secude on master (We are just doing this for demo purpose) 

`kubectl taint node $(hostname) node-role.kubernetes.io/master:NoSchedule-`{{execute}}

## Create pod 

As of now our kubernetes cluster is empty - lets quickly create a simple `nginx` pod 

`kubectl run tester --image=nginx`{{execute}} 

Idea here is we need to back up this data and whenever we restore this backup we need to make sure above pod
`tester` is always there.

Kubernetes disaster recovery plan is usually consist of backing up etcd cluster and having infrastructure as a code to provision new set of servers in the cloud.  


