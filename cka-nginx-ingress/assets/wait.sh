#!/bin/bash

show_progress()
{
  echo "environment ready"
  clear
  export GREEN='\033[0;32m'
  export RED='\033[0;31m'
  export YELLOW='\033[1;33m'
  export CYAN='\033[0;36m'
  export NC='\033[0m' # No Color
  echo -e  -n "Upgrading kubeadm to 1.19"
  local -r pid="${1}"
  local -r delay='0.75'
  local spinstr='\|/-'
  local temp
  while true; do
    [ $(kubeadm version | grep 1.19 | wc -l) -eq 1 ]
    if [[ "$?" -ne 0 ]]; then
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\b\b\b\b\b\b"
    else
      break
    fi
  done
  printf "    \b\b\b\b"
  echo ""
  echo -e  "${GREEN}Done${NC} upgrading ${CYAN}kubeadm${NC}"

  echo -e  -n "Upgrading kubelet and kubectl to 1.19"
  while true; do
    [ $(kubectl version --client --short | grep 1.19 | wc -l) -eq 1 ]
    if [[ "$?" -ne 0 ]]; then
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\b\b\b\b\b\b"
    else
      break
    fi
  done
  printf "    \b\b\b\b"
  echo ""
  echo -e  "${GREEN}Done${NC} upgrading ${CYAN}kubectl to 1.19 ${NC}"

  echo -e  -n "Upgrading kubelet to 1.19"
  while true; do
    [ $(kubelet --version | grep 1.19 | wc -l) -eq 1 ]
    if [[ "$?" -ne 0 ]]; then
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\b\b\b\b\b\b"
    else
      break
    fi
  done
  printf "    \b\b\b\b"
  echo ""
  echo -e  "${GREEN}Done${NC} - upgrading kubeadm,kubectl and kubelet"

  echo -e  -n "Creating Kubernetes cluster using kubeadm"
  while true; do
    [ $(kubectl version --short -o json | jq .serverVersion.minor -r) -eq 19 ]
    if [[ "$?" -ne 0 ]]; then
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\b\b\b\b\b\b"
    else
      break
    fi
  done
  printf "    \b\b\b\b"
  echo ""
  echo -e  "${GREEN}Done${NC} creating ${CYAN}cluster of version 1.19 ${NC}"

  echo -e  -n "Installing helm 3 tool"
  while true; do
    type helm > /dev/null 2>&1
    if [[ "$?" -ne 0 ]]; then
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\b\b\b\b\b\b"
    else
      break
    fi
  done
  printf "    \b\b\b\b"
  echo ""
  echo -e  "${GREEN}Done${NC} installing ${CYAN}Helm 3 ${NC}"

  sleep 1

  clear
}

show_progress