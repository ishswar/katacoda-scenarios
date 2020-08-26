#!/bin/bash

show_progress()
{
  echo "Welcome to k3s and Octant world"
  sleep 2
  clear
  printf "PS1='\t [\u@\h \W]\$ '" >> ~/.bashrc
  . ~/.bashrc
}

show_progress