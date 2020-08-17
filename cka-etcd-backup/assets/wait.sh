#!/bin/bash

show_progress()
{
  echo "environment ready"
  clear
#  GREEN='\033[0;32m'
#  CYAN='\033[0;36m'
#  NC='\033[0m' # No Color
#  echo -e  -n "Starting to install k3d CLI"
#  local -r pid="${1}"
#  local -r delay='0.75'
#  local spinstr='\|/-'
#  local temp
#  while true; do
#    type k3d > /dev/null 2>&1
#    if [[ "$?" -ne 0 ]]; then
#      temp="${spinstr#?}"
#      printf " [%c]  " "${spinstr}"
#      spinstr=${temp}${spinstr%"${temp}"}
#      sleep "${delay}"
#      printf "\b\b\b\b\b\b"
#    else
#      break
#    fi
#  done
#  printf "    \b\b\b\b"
#  echo ""
#  echo -e  "${GREEN}Done${NC} installing ${CYAN}k3d${NC} CLI"
#  echo -e  -n "Installing k3s cluster 1"
#  while true; do
#    kubectl get pods --context=k3d-k8s  > /dev/null 2>&1
#    if [[ "$?" -ne 0 ]]; then
#      temp="${spinstr#?}"
#      printf " [%c]  " "${spinstr}"
#      spinstr=${temp}${spinstr%"${temp}"}
#      sleep "${delay}"
#      printf "\b\b\b\b\b\b"
#    else
#      break
#    fi
#  done
#  printf "    \b\b\b\b"
#  echo ""
#  echo -e  "${GREEN}Done${NC} installing ${CYAN}k3s cluster 1${NC}"
#  echo -e  -n "Installing k3s cluster 2"
#  while true; do
#    kubectl get pods --context=k3d-dk8s  > /dev/null 2>&1
#    if [[ "$?" -ne 0 ]]; then
#      temp="${spinstr#?}"
#      printf " [%c]  " "${spinstr}"
#      spinstr=${temp}${spinstr%"${temp}"}
#      sleep "${delay}"
#      printf "\b\b\b\b\b\b"
#    else
#      break
#    fi
#  done
#  printf "    \b\b\b\b"
#  echo ""
#  echo -e  "${GREEN}Done${NC} - ${CYAN}ALL${NC} clusters are installed and configured"
#  sleep 1
#  clear
}

show_progress