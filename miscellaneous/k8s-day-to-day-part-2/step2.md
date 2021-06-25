## Pod & Deployment 

### Untaint 

Let's remove taint from master node so it can run workload 

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{execute}}

### Create a POD 

`kubectl run my-py-app --image=ishswar/webpyapp:1.0.1 --port=8080`{{execute}}

Check if JOB got created 

`kubectl get pods`{{execute}}

### Delete POD 

`kubectl delete pod my-py-app --force`{{execute}}

### Create a Deployment 

`kubectl create deployment my-py-ap --image=ishswar/webpyapp:1.0.1 --port=8080`{{execute}}
