## Create a volume 

### Storage class 

Install rancher's local storage - storageClass 

`kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml`{{execute}} 

### Create PVC 

Create a PVC that will use above Storage class to dynamically provision storage 

```
cat > py-app-pvc.yaml <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pyapp-pv-claim
spec:
  storageClassName: local-path
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
EOF
```
Create PVC 

`kubectl apply -f py-app-pvc.yaml`{{execute}}

Check if PVC is created 

`kubectl get pvc`{{execute}}

### Create a JOB

Create a JOB who's single task is to download `app.py` from Git hub and copy it to volume 
Once that is done JOB's job is done 

```
cat << EOF > py-app-update-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: update-app-job
spec:
  template:
    spec:
      containers:
      - name: update-app
        image: bash
        command: ["sh",  "-c", "wget https://raw.githubusercontent.com/pranay-tibco/py-flask/demo-k8s-day-to-day/app.py -O /opt/app.py"]
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /opt
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: pyapp-pv-claim
      restartPolicy: Never
  backoffLimit: 4
EOF
``` 

Create a JOB 

`kubectl apply -f py-app-update-job.yaml`{{execute}}

Check status of job 

`kubectl get jobs`{{execute}}

### Check log of pod 

We will see live how to do this 