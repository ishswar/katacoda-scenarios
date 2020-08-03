Install first K3S cluster in docker using K3d ( also add 2 nodes to this cluster)

## Install k3d cluster with name _k8s_

Once you run below command - k3d will create k3s cluster in docker container with 2 additional nodes as well 
Each of 3 - one master and 2 Nodes will run in it's own docker containers

k3d will also set _kubectl_ context with name _k8s_ for you 

`k3d cluster create k8s -a 2`{{execute}}
