#!/usr/bin/env bash

USAGE_TOOL="Usage: $0 <KEY> <VALUE>"

echo "export $1=$2" >> ~/.bashrc

echo "------------------------------------------------------"
echo "Env $1=$2 added."
echo "------------------------------------------------------"