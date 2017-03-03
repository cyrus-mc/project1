#!/usr/bin/env bash

# update APT
apt-get update

# install necessary packages
apt-get install -y python-pip
pip install flask
pip install flask-api

# copy files into place
cp /home/vagrant/query_proc.py /srv/
cp /home/vagrant/conf/query_proc /etc/default/
cp /home/vagrant/upstart/query_proc /etc/init/query_proc.conf

# finally, start the service
service query_proc start
