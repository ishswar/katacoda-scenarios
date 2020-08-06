First lets **install** k3d

## Install k3d CLI

We will install _[k3d](https://k3d.io/)_ CLI tools using bash script provided on [k3d site](https://k3d.io/#installation) 

`wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash -`{{execute}}

### Sample output : 

```bash
# wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash -
Preparing to install k3d into /usr/local/bin
k3d installed into /usr/local/bin/k3d
Run 'k3d --help' to see what you can do with it.
```

### What k3d can do ? 

`k3d help`{{execute}}

```
k3d is a wrapper CLI that helps you to easily create k3s clusters inside docker.
Nodes of a k3d cluster are docker containers running a k3s image.
All Nodes of a k3d cluster are part of the same docker network.
```
  