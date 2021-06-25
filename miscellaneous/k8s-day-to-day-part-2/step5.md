
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

We can test it uisng our Cluster IP end-point 

`kubectl run tester --rm=true --image=curlimages/curl --restart=Never -it -- curl http://my-py-ap-service:8080/visits-counter/`


