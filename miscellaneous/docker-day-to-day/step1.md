
## Install docker

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


### Expected output : 
  
```bash
Apache Maven 3.6.0
Maven home: /usr/share/maven
Java version: 1.8.0_282, vendor: Private Build, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "4.15.0-122-generic", arch: "amd64", family: "unix"
```

