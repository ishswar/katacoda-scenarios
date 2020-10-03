Inspect HA Setup 

# Who is leader

As we see from below diagram only one of scheduler can be active at a time - and that esentailly decides 
who is leader in this HA setup 

![HA Setup in Katacoda](./assets/Kubernetes_HA_Control_plane_setup_on_Katacoda.png)

In order to find out who is leader we can run below kubectl command 

`
kubectl get endpoints kube-scheduler -n kube-system -o jsonpath="{.metadata.annotations.control-plane\.alpha\.kubernetes\.io/leader}" | jq .
`{{execute}}

Out might look like this - the field holderIdentity tells us which master is **leader** 
in below case it is 'controlplane'

```
{
  "holderIdentity": "controlplane_737f8152-4247-49d4-b3c9-c279dc32fff8",
  "leaseDurationSeconds": 15,
  "acquireTime": "2020-10-03T09:19:00Z",
  "renewTime": "2020-10-03T09:20:31Z",
  "leaderTransitions": 0
}
```