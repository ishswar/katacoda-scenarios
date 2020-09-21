Authorize john to list,delete and create Pods 

## Create Role and Role Binding

Part of RBAC - we need to define the Role and Role Binding for user `john` to access Kubernetes Cluster resources - PODs 

We need to switch back to default user in our kubectl so we can do below administrative actions 

`
kubectl config use-context kubernetes-admin@kubernetes
`{{execute}}

### We will first create Role that can list,update/delete Pods and then add `john` to that Role via Role binding

This is a sample script to create ***role*** for this new user, Role name is called `developer`
This is role for `default` namespace 

`
kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
`{{execute}}

This is a sample script to create ***role binding*** for this new user , Role binding name is called `developer-binding-john`

`
kubectl create rolebinding developer-binding-john --role=developer --user=john
`{{execute}}


## Switch back as `john` and try listing pods again 

Change kubecontext to john

`
kubectl config use-context john
`{{execute}

Now we can again run kubectl commands as 'john' - let's try to get pods 

`
kubectl get pods
`{{execute}} 

This time it worked !!! 

### List name spaces ? 

If we try to list namespaces as john it fails as it is not authorized to do that 

`
$ kubectl get ns
Error from server (Forbidden): namespaces is forbidden: User "john" cannot list resource "namespaces" in API group "" at the cluster scope
`