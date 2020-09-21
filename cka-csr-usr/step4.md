Get certificate signed 

## Approve the CSR 

You can see that now CSR is in `Pending` state and waiting for kube admin to approve it 

`kubectl get csr`{{execute}}

Now let's approve above CSR

`
kubectl certificate approve john
`{{execute}}

Once the certificate is approved we need to extract signed certificte and save it as john.crt file 

- Approved certificate can be retrieved using below command 

`
kubectl get csr john -o jsonpath="{.status.certificate}{'\n'}"
`{{execute}}

- Above certicicate is in base64 encoded string we need to decode it to see real PEM encoded certificate 

`
kubectl get csr john -o jsonpath="{.status.certificate}" | base64 -d
`{{execute}}

- Save above output as john.crt file 

`
kubectl get csr john -o jsonpath="{.status.certificate}" | base64 -d > john.crt
`{{execute}}

- (Optionally) We can see that this certificate is signed by "kubernetes" (Signing authority) and validity is 1 year

`openssl x509 -in john.crt -text`{{execute}}

Same can be seen in sample image below : 

![](https://raw.githubusercontent.com/ishswar/katacoda-scenarios/master/cka-csr-usr/assets/approved_cert.png)


**john** is now a __Normal user__ using his certificates *john.crt* and *john.key* he can authenticate and invoke API. This is because he has certificate
issued (signed) by the Kubernetes Cluster, He can present this Certificate to make the API call as the Certificate Header, or through the kubectl.

Now let see how we setup ***kubectl*** to use this certificates to make an API calls on behalf of ***John*** 



