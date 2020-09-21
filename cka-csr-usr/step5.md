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


