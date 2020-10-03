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


## Configure NGINX to load balance among two master nodes (machines)

In this scenario we are going to install first master node on same machine as NGINX server named **controlplane** 
second master node will be installed on server named **node01**

### Build pass-through NGINX configuration file 

#### Get IP address of servers

Before we build pass through config file we need IP Address of two servers 

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
`{{execute}}

We need to configure NGINX to use these two IP Address for load balancing 

`
cat << EOF > /etc/nginx/passthrough.conf
stream {
    upstream controlplane {
        server $MASTER_IP:6443 max_fails=3 fail_timeout=10s;
        server $MASTER_2_IP:6443 max_fails=3 fail_timeout=10s;
    }
log_format basic '$remote_addr [$time_local] '
                 '$protocol $status $bytes_sent $bytes_received '
                 '$session_time "$upstream_addr" '
                 '"$upstream_bytes_sent" "$upstream_bytes_received" "$upstream_connect_time"';
    access_log /var/log/nginx/control.plane.master_access.log basic;
    error_log /var/log/nginx/wcontrol.plane.master_error.log;
    server {
        listen 9443;
        proxy_pass controlplane;
        proxy_next_upstream on;
    }
}
EOF
`{{execute}}

We are telling NGINX to listen on port **9443** in above configuration -
that will be our port to access API server in our `~/.kueb/config` file
We are also assuming the two control plane will come up on port **6443** on
their respective IPs

*(Optional)*
If you want to see how (final) config file looks like use this command 

`bat /etc/nginx/passthrough.conf || cat /etc/nginx/passthrough.conf`{{execute}}

### Update nginx.conf to use pass through config

`
if [ $(cat /etc/nginx/nginx.conf | grep passthrough | wc -l) -eq 1 ]; 
 then
   echo "NGINX Config already has passthrough config added"; 
 else 
  echo "Adding passthrought config to nginx config file ";
  echo  ""
  echo "include /etc/nginx/passthrough.conf;" >> /etc/nginx/nginx.conf
fi
`{{execute}}

*(Optional)*
Check out nginx.conf file 

`bat /etc/nginx/nginx.conf || cat /etc/nginx/nginx.conf`{{execute}}

## Start NGINX service 

We will just restart (if not started this will start the service) NGINX service

`
echo "Starting NGINX Service"
echo ""
systemctl restart nginx
echo "Checking NGINX Service status"
echo ""
if (systemctl status nginx) ;
  then
    echo "NGINX Service started successful"
  else
    echo "NGINX Service did not start successful - need to investigate";
fi
`{{execute}}

### Check NGINX is listening on port 9443 

`
FIRST_MACHINE_NAME=controlplane
LB_PORT=9443
LB_IP=$(dig $FIRST_MACHINE_NAME +short)
if [ -n "$LB_IP" ];
 then
    echo "";
 else
    echo "Could not find LB_IP from hostname '$FIRST_MACHINE_NAME' trying using hostname command now";
    LB_IP=$(hostname -I | cut -d " " -f 1)
fi
nc -zv "$LB_IP" $LB_PORT || { echo "Issue connecting to load balanacer @ $LB_IP:$LB_PORT - this needs to be investigated"; }
`{{execute}}

We are done with NGINX setting - we can proceed to now setting up kubernetes first control plane