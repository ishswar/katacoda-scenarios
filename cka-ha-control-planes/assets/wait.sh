#!/bin/bash

show_progress()
{
  echo "environment ready"
  clear
  export GREEN='\033[0;32m'
  export RED='\033[0;31m'
  export LRED='\033[1;31m'
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

  echo -e  -n "Upgrading kubeadm,kubelet and kubectl to 1.19 on remote machine node01"
  while true; do
    [ $(ssh node01 kubectl version --client --short | grep 1.19 | wc -l) -eq 1 ]
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
  echo -e  "${GREEN}Done${NC} upgrading ${CYAN}kubeadm,kubelet and kubectl to 1.19 ${NC}"

  sleep 1

  clear
}

show_progress