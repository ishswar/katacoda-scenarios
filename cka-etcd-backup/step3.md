Scenario 2

## Multi Containers pod 

Create a namespace called `ggckad-s0`{{copy}} in your cluster.
Run the following pods in this namespace.

- [ ] A pod called pod-a with a single container running the `kubegoldenguide/simple-http-server`{{copy}} image
- [ ] A pod called pod-b that has one container running the `kubegoldenguide/alpine-spin:1.0.0`{{copy}} image, and one container running nginx:1.7.9

Write down the output of `kubectl get pods`{{copy}} for the ggckad-s0 namespace.

### Use Context 

`kubectl config use-context k3d-k8s`{{copy}}