# Phase 1

Simple API service to query /proc/{cpuinfo,meminfo,uptime} packaged in a
Ubuntu 14.04 Vagrant image.

Usage:

  - checkout repository
  - vagrant up
  - vagrant ssh

Verify API service:

  - curl -O http://localhost:1404/{cpuinfo,meminfo,uptime}

