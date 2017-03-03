# project1

Simple Flask API service that returns contents of files, in json format.

Encapsulate service inside Vagrant Ubuntu 14.04 box, using shell provisioner. Expose service on public IP assigned to the VM.

Usage:

  1) Bring up vagrant box: vagrant up
  2) SSH to box: vagrant ssh
  3) Retrieve Public IP: ip a s eth1

Access API from any other machine on your network through http://PUBLIC_IP:1404/..

If you want to change the LISTEN IP or PORT modify the upstart environment file in conf.

