## Create a volume 

### Storage class 

Install rancher's local storage - storageClass 

`kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml`{{execute}} 

### Create PVC 

`
cat << EOF > py-app-pvc.yaml
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
`{{execute}} 

### Create a JOB

`
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
`{{execute}} 

### Check log of pod 

We will see live how to do this 