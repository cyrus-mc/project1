# project1

Simple Flask API service that returns contents of files, in json format.

Encapsulate service inside Vagrant Ubuntu 14.04 box, using shell provisioner. Expose service on public IP assigned to the VM.

Usage:

  - Bring up vagrant box by issuing command vagrant up
  - Determine IP assigned to bridge interface by SSHing into machine using vagrant ssh
  - Run following command to retrieve the bridged interface IP: ip a s eth1

Access API from any other machine on your network through http://PUBLIC_IP:1404/..

You can modify the interface and port binding by modifying the query_proc file within the conf directory.
