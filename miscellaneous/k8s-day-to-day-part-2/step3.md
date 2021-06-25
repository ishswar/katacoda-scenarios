## Create a volume 

### Storage class 

Install rancher's local storage - storageClass 

`kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml`{{execute}} 

### Create PVC 

Create a PVC that will use above Storage class to dynamically provision storage 

`
cat << EOF > /etc/nginx/passthrough.conf
stream {
    upstream controlplane {
        server $MASTER_IP:6443 max_fails=3 fail_timeout=10s;
        server $MASTER_2_IP:6443 max_fails=3 fail_timeout=10s;
    }
log_format basic '$remote_addr [$time_local] '
                 '$protocol $status $bytes_sent $bytes_received '
                 '$session_time "$upstream_addr" '
                 '"$upstream_bytes_sent" "$upstream_bytes_received" "$upstream_connect_time"';
    access_log /var/log/nginx/control.plane.master_access.log basic;
    error_log /var/log/nginx/control.plane.master_error.log;
    server {
        listen 9443;
        proxy_pass controlplane;
        proxy_next_upstream on;
    }
}
EOF
`{{execute}}

---

```
    cat > hc.yaml <<EOF
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

---

 ```
    cat > hc.yaml <<EOF
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

```
    cat << EOF > py-app-pvc.yaml
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