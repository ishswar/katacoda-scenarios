#!/bin/bash

show_progress()
{
  echo "Welcome to k3s and Octant world"
  sleep 2
  clear
  PS1='[\u@\h \W] \D{%T}\$ '
}

show_progress