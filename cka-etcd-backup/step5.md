Scenario 4

## Missed deployment 

The operator needed to deploy Deployment named `deploy-charts`{{copy}} in `marketing`{{copy}} namespace, but it looks like he deployed it in the wrong namespace;
as it is not there in `marketing` namespace. He has marked TASK as Resolved and gone for a long weekend - we need your help in finding that Deployment
(it must be there in a cluster) and move it to `marketing` namespace. You can delete old Deployment.

### Use Context 

`kubectl config use-context k3d-k8s`{{copy}} 