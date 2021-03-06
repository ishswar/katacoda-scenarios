The only stateful component of Kubernetes cluster is etcd server. The etcd server is where Kubernetes store all API objects and configuration.
Backing up this storage is sufficient for complete recovery of Kubernetes cluster state.

In this scenario we will perform these steps to learn about etcd backup  

1. Create quick kubernetes **cluster** - One master, with *[Canal](https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel#installing-with-the-kubernetes-api-datastore-recommended)* networking) 
1. Install `etcdctl` **client** 
1. Create one simple pod (just to **populate** cluster)
1. Take a **backup** etcd (using *etcdctl*)
1. Create one more simple pod (this will be gone after we ***restore*** the etcd)
1. **Restore** etcd 
1. Check the cluster again second pod create above should be **gone** 
