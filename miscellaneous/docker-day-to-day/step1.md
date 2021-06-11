
## Install docker

We will be installing on **Ubuntu 20.04** machine 

Follow steps from [Docker.io](https://docs.docker.com/engine/install/ubuntu/)

### Uninstall old versions

   `sudo apt-get remove docker docker-engine docker.io containerd runc`{{execute}}
   
### Install using the repository

#### Set up the repository
   
   `sudo apt-get update`{{execute}}
   
   `sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y`{{execute}}

   `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`{{execute}}
   
   `echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`{{execute}}
   
   `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`{{execute}}
   
#### Install Docker Engine
   
   `sudo apt-get update`{{execute}}  
   `sudo apt-get install docker-ce docker-ce-cli containerd.io -y`{{execute}}
   
#### Manage Docker as a non-root user   
   
   `sudo groupadd docker`{{execute}}  
   `sudo usermod -aG docker $USER`{{execute}}  
   `newgrp docker`{{execute}}  
   
#### Verify that Docker Engine is installed correctly by running the `hello-world` image.    

   `docker run hello-world`{{execute}}  

## Make sure Docker daemon is running 

Command to run to check that is : `docker info`{{execute}} 

### Expected output : 
  
```bash
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Build with BuildKit (Docker Inc., v0.5.1-docker)
  scan: Docker Scan (Docker Inc., v0.8.0)

Server:
 Containers: 2
  Running: 0
  Paused: 0
  Stopped: 2
 Images: 11
 Server Version: 20.10.7
 Storage Driver: overlay
  Backing Filesystem: extfs
  Supports d_type: true
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 1
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runtime.v1.linux runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: d71fcd7d8303cbf684402823e425e9dd2e99285d
 runc version: b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: default
 Kernel Version: 5.4.0-52-generic
 Operating System: Ubuntu 20.04.1 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 1.449GiB
 Name: host01
 ID: FM75:XC6F:ENAO:AVR6:XUVN:F3UP:TVIG:AAUV:2LGU:6XW6:IACB:WFUE
 Docker Root Dir: /var/lib/docker
 Debug Mode: true
  File Descriptors: 22
  Goroutines: 34
  System Time: 2021-06-11T22:53:11.087786912Z
  EventsListeners: 0
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  docker-registry-mirror.katacoda.com
  registry.test.training.katacoda.com:4567
  127.0.0.0/8
 Registry Mirrors:
  http://docker-registry-mirror.katacoda.com/
 Live Restore Enabled: false

WARNING: No swap limit support
WARNING: the overlay storage-driver is deprecated, and will be removed in a future release.
```
## Check Docker service is running 

Sometime you might have to check if services that enable you to run docker on machine are running or not 
You can check them on Ubuntu using below two commands - both of them should be in `running` state .

`sudo systemctl status docker.service --no-pager`{{execute}} 
`sudo systemctl status containerd.service --no-pager`{{execute}} 

