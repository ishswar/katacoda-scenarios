Create second master node in cluster 

# Create second master 

For this we need to run `kubeadm join` command but also add flag `--control-plane` 

## Get join command 

On first master server run below command to get join command that we need to execute on second server.

`
timeout 1 openssl s_client -connect 0.0.0.0:30443 -showcerts 2> /dev/null |  openssl x509 -noout  -subject
`{{execute}}

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 -keyout private-p.key -out certificate-pshah.crt
curl --insecure -vvI https://www.google.com 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'

curl --insecure -vvI https://foo.com:31080 2>&1 | grep -A1 "Server certificate"