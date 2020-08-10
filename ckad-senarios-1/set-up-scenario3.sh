kubectl create ns auditing
kubectl create ns marketing
kubectl create cronjob -n auditing doaudits --image=busybox --schedule="*/1 * * * *" -- sleep 4
kubectl create cronjob -n marketing sendInfo --image=busybox --schedule="*/1 * * * *" -- sleep 2
kubectl create cronjob -n marketing sendinfo --image=busybox --schedule="*/1 * * * *" -- sleep 2
sleep 2m
kubectl -n marketing patch cronjobs.batch sendinfo -p '{"spec":{"suspend":true}}'

