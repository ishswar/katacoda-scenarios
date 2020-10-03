Create cluster 

# Install NGINX 

We will first install NGINX , we will not start it yet

`
wget https://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
cat << EOF > /etc/apt/sources.list.d/nginx.list
deb http://nginx.org/packages/ubuntu/ xenial nginx
deb-src http://nginx.org/packages/ubuntu/ xenial nginx
EOF
sudo apt-get update
sudo apt-get install nginx
`{{execute}}


## Configure NGINX to load balance among two master nodes

In this scenario we are going to install first master node on same machine as NGINX server named **controlplane** 
second master node will go on server named **node01**

### We need their IP address 

`
MASTER_IP=$(dig controlplane +short)
if [ -n "$MASTER_IP" ];
 then
    echo "";
 else
    echo "Could not find MASTER_IP from hostname 'controlplane' trying using hostname command now";
    MASTER_IP=$(hostname -I | cut -d " " -f 1)
fi
MASTER_2_IP=$(dig node01 +short)
`

We need to configure NGINX to use these two 

As of now cluster is not ready (master node) - because it is waiting network to be add to cluster
Lets installed [Canal](https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel) network to cluster 

`
curl https://docs.projectcalico.org/manifests/canal.yaml -O
kubectl apply -f canal.yaml
`{{execute}}

