Create second master node in cluster 

# Create second master 

For this we need to run kubeadm join command but as --control-plane 

## Get join command 

On first master server run below command to get join command that we need to execute on second server.

`
echo "Generating joining command that remote kubeadm can use to join this cluster"
CERT_KEY=$(kubeadm init phase upload-certs --upload-certs | sed -n 3p)
CONTROL_PLANE_JOIN_COMMAND=$(kubeadm token create --print-join-command --certificate-key "$CERT_KEY")
`{{execute}}

## Run kubeadm join on second server 

Now we can run kubeadm join command on second server `node01` but before that we need to install kubeadm
on that server . kubelet is already there on that server.

### Install kubeadm on second server 

`
ssh node01 apt-get install kubeadm=1.19.0-00 -y -qq;kubeadm version -o short
`{{execute}}

Now we run above `kubeadm join` command on second server (node01) that will create a **second** master node in cluster 

`
SECOND_MACHINE_NAME=node01
echo "JOIN COMMAND is [$CONTROL_PLANE_JOIN_COMMAND]"
echo "$CONTROL_PLANE_JOIN_COMMAND" > join.text
echo "Running joining command from remote machine"
echo ""
ssh $SECOND_MACHINE_NAME "$CONTROL_PLANE_JOIN_COMMAND"
`{{execute}}

