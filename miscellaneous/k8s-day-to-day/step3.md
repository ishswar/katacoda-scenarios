
## Most used commands 

![](./assets/kubectl-commands.png)

## Deploy our Python web App



`kubectl create deployment my-py-ap --image=ishswar/webpyapp:1.0.1 --port=8080`{{execute}}

`kubectl get deployments.apps my-py-ap`{{execute}}

`kubectl get pods`{{execute}}

`kubectl describe nodes controlplane | grep Taint`{{execute}}

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{execute}}

`kubectl get pods`{{execute}}

#