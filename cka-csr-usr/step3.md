Create a john's Certificates (Private and Public certs)

## Create certificate for John

This will create private certificate for John

`openssl genrsa -out john.key 2048`{{execute}}

## Create Certificate Signing Request (CSR)

We will create a CSR in *Non-interactive* way

This is the place you decide what will be username for your user - we are using *john* (CN=john) in our case
Organization for *john* is *devops* 

Create a configuration file with the content required to generate CSR. We will use below file.

`
cat << EOF > server_cert.cnf
[req]
distinguished_name = req_distinguished_name
prompt = no
[req_distinguished_name]
C = US
O = devops
OU = devops
CN = john
EOF
`{{execute}}

Now generate CSR file using openssl , we will pass above request file as input so openssl will not prompt for any input

`
openssl req -new -key john.key -out john.csr -config server_cert.cnf
`{{execute}}

(Optional) - if you are curious to see how Certification Singing request file (.csr) looks like you can use OpenSSL tool to see it 
`openssl req -noout -text -in john.csr`{{execute}}

## Create Kubernetes CertificateSigningRequest request

Now we will create a CertificateSigningRequest and submit it to a Kubernetes Cluster via kubectl. We already have template file certificatesigningrequest.yaml 
(Optional) You can view it if want to `bat /root/certificatesigningrequest.yaml`{{execute}}

- First we will have to convert CSR file to base54 encoded string store it in variable `JOHN_CSR`
- Now we will substitute that value in certificatesigningrequest.yaml file 

`
JOHN_CSR=$(cat john.csr | base64 | tr -d "\n")
sed -i "s/BASE64ENCODE/${JOHN_CSR}/g" certificatesigningrequest.yaml
`{{execute}}

(Optional) View updated ***yaml*** file that we are about to submit to API server `bat /root/certificatesigningrequest.yaml`{{execute}}

In kubernetes 1.19 certificatesigningrequest also needs to have `spec.signerName` defined - in our case we have set it to `kubernetes.io/kube-apiserver-client`

Send this Certificate singing request to API server 

`kubectl apply -f certificatesigningrequest.yaml`{{execute}} 

Certificate singing request has been sent to cluster, next we will get this request approved