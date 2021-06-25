
## Update our py-app to mount that shared volume 

```
cat << EOF > deploy-2.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: my-py-ap
  name: my-py-ap
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-py-ap
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: my-py-ap
    spec:
      containers:
      - image: ishswar/webpyapp:1.0.1
        name: webpyapp
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: app-persistent-storage
          mountPath: /opt     
        resources: {}
      volumes:
      - name: app-persistent-storage
        persistentVolumeClaim:
          claimName: pyapp-pv-claim  
EOF
```
## Apply changes 

`kubectl apply -f deploy-2.yaml`{{execute}}

## Wait for changes to be propagated on all 3 pods 

```bash
kubectl get pods
NAME                        READY   STATUS        RESTARTS   AGE
my-py-ap-74df466df9-lxzmd   1/1     Running       0          5s
my-py-ap-74df466df9-ptxqz   0/1     Pending       0          0s
my-py-ap-74df466df9-s8bnw   1/1     Running       0          2s
my-py-ap-77c79c4cfd-5kqv2   1/1     Terminating   0          7m14s
my-py-ap-77c79c4cfd-gq4ps   1/1     Running       0          8m21s
my-py-ap-77c79c4cfd-nlbv8   1/1     Terminating   0          6m4s
update-app-job-p5zph        0/1     Completed     0          2m47s
``` 

We can test it using our Cluster IP end-point 

`kubectl run tester --rm=true --image=curlimages/curl --restart=Never -it -- curl http://my-py-ap-service:8080/visits-counter/`{{execute}}


