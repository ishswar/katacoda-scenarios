#!/bin/sh

while true; do
  READY_COUNT=$(kubectl get nodes -o json | grep -i kubeletReady | wc -l)
    if [ $READY_COUNT -eq 4 ]; then
   {
     echo "All nodes are posting ready"
     kubectl get nodes -o wide
     break;
   }
   else {
     echo "Found $(kubectl get nodes -o json | grep -i kubeletReady | wc -l) Node(s) in Ready state - expecting 4 to be Ready";
     sleep 5;
   }
  fi
done