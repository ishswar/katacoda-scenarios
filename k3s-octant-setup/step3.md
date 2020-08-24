Install Octant dashboard 

## Octant dashboard 

Download Octant distribution from github and un-tar it 

`
wget https://github.com/vmware-tanzu/octant/releases/download/v0.13.1/octant_0.13.1_Linux-64bit.tar.gz
tar -xf octant_0.13.1_Linux-64bit.tar.gz
`{{execute}}

## Start Octant on port 80 

`
OCTANT_LISTENER_ADDR=0.0.0.0:80 ./octant
`{{execute}}