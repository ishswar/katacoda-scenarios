#!/bin/bash

show_progress()
{
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo -e  -n "Starting to install k3d CLI"
  local -r pid="${1}"
  local -r delay='0.75'
  local spinstr='\|/-'
  local temp
  while true; do
    type k3d > /dev/null 2>&1
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
  echo -e  "${RED}Done${NC} installing k3d CLI"
  echo -e  -n "Installing k3s cluster 1"
  while true; do
    kubectl get pods --context=k3d-k8s  > /dev/null 2>&1
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
  echo -e  "${RED}Done${NC} installing k3s cluster 1"
  echo -e  -n "Installing k3s cluster 2"
  while true; do
    kubectl get pods --context=k3d-dk8s  > /dev/null 2>&1
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
  echo -e  "${RED}Done${NC} - all clusters are installed and configured"
}

show_progress