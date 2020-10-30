Create a backup

## Check IP-Tables on kind-worker node 

In order to see IP Tables entry in kube-proxy pod running on node kind-worker we need kube-proxy pod's name 
Let's fine that 

We know pod is running on node `kind-worker` and it has label `k8s-app=kube-proxy` attach to it - with that tow info we 
should be able to get POD name 

`KUBEPROXY_POD_ON_WORKER_NODE=$(kubectl get pods -n kube-system \
--field-selector=spec.nodeName=kind-worker -l k8s-app=kube-proxy -o name \
--no-headers)`{{execute}}

Now using that POD name execute command inside the container and grep for iptables entry to Service `test-svc` 

`echo "Getting iptables related to defalut/test-svc on kind-worker node"
kubectl exec -it -n kube-system $KUBEPROXY_POD_ON_WORKER_NODE -- iptables-save | grep test-svc
`{{execute}}

Sample output: 

```
controlplane $ kubectl exec -it -n kube-system kube-proxy-z8w5v -- iptables-save | grep test-svc
-A KUBE-NODEPORTS -s 127.0.0.0/8 -p tcp -m comment --comment "default/test-svc" -m tcp --dport 32070 -j KUBE-MARK-MASQ
-A KUBE-NODEPORTS -p tcp -m comment --comment "default/test-svc" -m tcp --dport 32070 -j KUBE-XLB-QKNQQNIN727HO3XU
-A KUBE-SEP-SQEBHSRBMT4ZUBXZ -s 10.244.1.3/32 -m comment --comment "default/test-svc" -j KUBE-MARK-MASQ
-A KUBE-SEP-SQEBHSRBMT4ZUBXZ -p tcp -m comment --comment "default/test-svc" -m tcp -j DNAT --to-destination 10.244.1.3:80
-A KUBE-SEP-SUSDB4Q4CAFDFR7F -s 10.244.2.3/32 -m comment --comment "default/test-svc" -j KUBE-MARK-MASQ
-A KUBE-SEP-SUSDB4Q4CAFDFR7F -p tcp -m comment --comment "default/test-svc" -m tcp -j DNAT --to-destination 10.244.2.3:80
-A KUBE-SERVICES ! -s 10.244.0.0/16 -d 10.96.115.88/32 -p tcp -m comment --comment "default/test-svc cluster IP" -m tcp --dport 80 -j KUBE-MARK-MASQ
-A KUBE-SERVICES -d 10.96.115.88/32 -p tcp -m comment --comment "default/test-svc cluster IP" -m tcp --dport 80 -j KUBE-SVC-QKNQQNIN727HO3XU
-A KUBE-SVC-QKNQQNIN727HO3XU -m comment --comment "default/test-svc" -m statistic --mode random --probability 0.50000000000 -j KUBE-SEP-SQEBHSRBMT4ZUBXZ
-A KUBE-SVC-QKNQQNIN727HO3XU -m comment --comment "default/test-svc" -j KUBE-SEP-SUSDB4Q4CAFDFR7F
-A KUBE-XLB-QKNQQNIN727HO3XU -m comment --comment "masquerade LOCAL traffic for default/test-svc LB IP" -m addrtype --src-type LOCAL -j KUBE-MARK-MASQ
-A KUBE-XLB-QKNQQNIN727HO3XU -m comment --comment "route LOCAL traffic for default/test-svc LB IP to service chain" -m addrtype --src-type LOCAL -j KUBE-SVC-QKNQQNIN727HO3XU
-A KUBE-XLB-QKNQQNIN727HO3XU -m comment --comment "default/test-svc has no local endpoints" -j KUBE-MARK-DROP
```

From above output you can see that on kind-worker node for service test-svc (in namespace default) there are no local end-points 

`
-A KUBE-XLB-QKNQQNIN727HO3XU -m comment --comment "default/test-svc has no local endpoints" -j KUBE-MARK-DROP
`

