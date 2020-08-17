Extra pod 

## Create one extra pod 

We will create one extra pod in cluster - as we are creating this pod after taking backup when we restore the backup 
cluster will forget about this pod as all source of truth is etcd DB.

`kubectl run forgetme --image=nginx`{{execute}}

