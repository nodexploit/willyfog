#!/usr/bin/env bash

# List all ports and the application listening on that port

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

netstat -tulpn