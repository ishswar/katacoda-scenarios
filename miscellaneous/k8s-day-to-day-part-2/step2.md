## Pod & Deployment 

### Untaint 

Let's remove taint from master node so it can run workload 

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{execute}}

### Create a POD 

`kubectl run my-py-app --image=ishswar/webpyapp:1.0.1 --port=8080`{{execute}}

Check if JOB got created 

`kubectl get pods`{{execute}}

Sample output - pay attention to Pod Name  

```bash
controlplane $ kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
my-py-app   1/1     Running   0          30s
```

### Delete POD 

`kubectl delete pod my-py-app --force`{{execute}}

### Create a Deployment 

`kubectl create deployment my-py-ap --image=ishswar/webpyapp:1.0.1 --port=8080`{{execute}}

Let see if POD was created by deployment or not 

`kubectl get pods`{{execute}}

Sample output - observe the change in POD name 

```bash
controlplane $ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
my-py-ap-77c79c4cfd-t27dw   1/1     Running   0          4s
```

### Let's scale the deployment 

We want to add one more pod so we can use this imperative command 

`kubectl scale deployment my-py-ap --replicas=2`{{execute}}

Check the pods again 

`kubectl get pods`{{execute}}

Sample output should look like this 

```
controlplane $ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
my-py-ap-77c79c4cfd-9sxdx   1/1     Running   0          4s
my-py-ap-77c79c4cfd-t27dw   1/1     Running   0          2m52s
```

### How to Extract YAML (Manifest) from running K8S object 

`kubectl get deployments.apps my-py-ap -o yaml > deploy.yaml`{{execute}}

Let's observe the YAML file 

`nano deploy.yaml`{{execute}}

Once done exit out of nano or use `clear`{{execute interrupt}} to exit 


### Scale the deployment using declarative way 

Edit the Deployment file and change `replica` count from 2 to 3 

You can open using vi or nano or use below command 

`sed -i 's/replicas\: 2/replicas\: 3/g' deploy.yaml`{{execute}}

Now let's apply this updated deployment file 

`kubectl apply -f deploy.yaml`{{execute}}

NOTE : you will see warning like 

`Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply` that is expected 

Now if you we check the pods we should see 3 pods 

`kubectl get pods`{{execute}}

Sample output 

```bash
controlplane $ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
my-py-ap-77c79c4cfd-7bdgw   1/1     Running   0          7s
my-py-ap-77c79c4cfd-9sxdx   1/1     Running   0          9m
my-py-ap-77c79c4cfd-t27dw   1/1     Running   0          11m
```
