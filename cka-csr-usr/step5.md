Setup kubectl to use john's certificates 

## Add certificates to KubeConfig

The last step is to add this user into the KubeConfig.

First, we need to add new credentials

`
kubectl config set-credentials john --client-key=john.key --client-certificate=john.crt --embed-certs=true
`{{execute}}

Then, we need to add the context

`kubectl config set-context john --cluster=kubernetes --user=john
`{{execute}}

To test it, change kubecontext to john

`kubectl config use-context john
`{{execute}}

All set - now we can run kubectl commands as 'john' - let's try to get pods 

`
kubectl get pods
`{{execute}} 

Oh, we got Error 

`
Error from server (Forbidden): pods is forbidden: User "john" cannot list resource "pods" in API group "" in the namespace "default"
`

This is because we have just done the Authentication part - we need to Authorize `john` to do seething on cluster - let do that next 

## Check audit logs 

As we have enable audit tracing we should be able to see above request getting loged in audit.log

`cat /var/log/audit.log | grep john | grep ResponseComplete | grep list | jq .`{{execute}}

In output you will see that username "john" who is part of group "devops" - his request was rejected "forbid"

<details>
  <summary>Click to sample output</summary>
  
```json
{
  "kind": "Event",
  "apiVersion": "audit.k8s.io/v1",
  "level": "Metadata",
  "auditID": "5daeb712-4bf3-4c7c-b35c-6ef26ad63976",
  "stage": "ResponseComplete",
  "requestURI": "/api/v1/namespaces/default/pods?limit=500",
  "verb": "list",
  "user": {
    "username": "john",
    "groups": [
      "devops",
      "system:authenticated"
    ]
  },
  "sourceIPs": [
    "172.17.0.46"
  ],
  "userAgent": "kubectl/v1.19.0 (linux/amd64) kubernetes/e199641",
  "objectRef": {
    "resource": "pods",
    "namespace": "default",
    "apiVersion": "v1"
  },
  "responseStatus": {
    "metadata": {},
    "status": "Failure",
    "reason": "Forbidden",
    "code": 403
  },
  "requestReceivedTimestamp": "2020-09-23T20:22:41.462143Z",
  "stageTimestamp": "2020-09-23T20:22:41.463723Z",
  "annotations": {
    "authorization.k8s.io/decision": "forbid",
    "authorization.k8s.io/reason": ""
  }
}
```
</details>
