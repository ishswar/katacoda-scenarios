Inspect HA Setup 

# Who is leader (in scheduler)

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

# Who is leader (in ETCD)

As seen ETCD component in HA setup is always active-active in all master nodes  

![](./assets/ETCD-active-active.png) 

Let see if we can use `etcdctl` tool to list current member of ETCD cluster and see who 
is leader 

`CACERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-trusted-ca-file | cut -d= -f2)
SERVER_KEY=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-key-file | cut -d= -f2)
SERVER_CERT=$(cat /etc/kubernetes/manifests/etcd.yaml | grep peer-cert-file | cut -d= -f2)
ENDPOINTS=$(cat /etc/kubernetes/manifests/etcd.yaml | grep advertise-client-urls= | cut -d= -f2)
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINTS --write-out=table --cacert $CACERT --cert $SERVER_CERT --key $SERVER_KEY \
   member list
`{{execute}}

You will see output like this :

`
+------------------+---------+--------------+--------------------------+--------------------------+------------+
|        ID        | STATUS  |     NAME     |        PEER ADDRS        |       CLIENT ADDRS       | IS LEARNER |
+------------------+---------+--------------+--------------------------+--------------------------+------------+
| 75c889cf7ea767d8 | started | controlplane | https://172.17.0.44:2380 | https://172.17.0.44:2379 |      false |
| b16e9358c8696a2b | started |       node01 | https://172.17.0.46:2380 | https://172.17.0.46:2379 |      false |
+------------------+---------+--------------+--------------------------+--------------------------+------------+
`

This shows one (**big**) problem - we can see both ETCD component of cluster is saying they it is not `leader`
This is because ETCD clusters are based on [raft](http://thesecretlivesofdata.com/raft/) consensus - and it needs [odd number](https://etcd.io/docs/v3.2.17/faq/) of members to reach consensus (elect leader)
As in our case we only have two members of ETCD cluster components there is no leader (yet!)

For now we are okay but with this setting we can't go in production - in this case it is better to have
**one** master node instead of **two** !!



