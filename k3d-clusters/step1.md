First lets **install** k3d

## Install k3d CLI

This is an _example_ of creating a scenario and running a **command**
We will install _[k3d](https://k3d.io/)_ CLI tools using bash script provided on k3d site 

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

```bash
k3d help
https://k3d.io/
k3d is a wrapper CLI that helps you to easily create k3s clusters inside docker.
Nodes of a k3d cluster are docker containers running a k3s image.
All Nodes of a k3d cluster are part of the same docker network.

Usage:
  k3d [flags]
  k3d [command]

Available Commands:
  cluster     Manage cluster(s)
  completion  Generate completion scripts for [bash, zsh, powershell | psh]
  help        Help about any command
  image       Handle container images.
  kubeconfig  Manage kubeconfig(s)
  node        Manage node(s)
  version     Show k3d and default k3s version

Flags:
  -h, --help      help for k3d
      --verbose   Enable verbose output (debug logging)
      --version   Show k3d and default k3s version

Use "k3d [command] --help" for more information about a command.
```