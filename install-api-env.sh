#!/usr/bin/env bash

# update APT
apt-get update

# install python PIP
apt-get install -y python-pip

# pip install Flask library
pip install flask

# determine our public IP
IP_ADDRESS=`hostname --all-ip-addresses`

# port to start service on
PORT=1440

# debug Yes or no?
DEBUG=True

python query_proc.py $IP_ADDRESS $PORT $DEBUG &
