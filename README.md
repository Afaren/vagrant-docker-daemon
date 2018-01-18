Vagrant Docker Daemon
=====================

# Overview

Vagrant box with docker daemon accessible from the outside world. Very useful for docker image builds under a windows based operating system.

# Features

* Creation Ubuntu 14.04 base box with vagrant
* Install Docker daemon with additional tools
* Open Docker daemon socket to use from a remote host
* Log DOCKER_HOST environment variable

# Prerequisites

# Usage

* Create virtual machine with vagrant:
  ```bash
  vagrant up
  ```

# Use case examples

## Windows

* Set DOCKER_HOST environment variable (use ip which is logged out by vagrant up):
  ```bash
  set DOCKER_HOST=tcp://172.28.128.2:2375
  ```  

* Use [docker-maven-plugin](https://dmp.fabric8.io/) from [fabric8](https://fabric8.io/) to build your docker images:
  ```bash
  mvn clean install docker:build
  ```  

## Linux   

* Set DOCKER_HOST environment variable (use ip which is logged out by vagrant up):
  ```bash
  export DOCKER_HOST=tcp://172.28.128.2:2375
  ```  

* Use docker command line to test some features with a fresh installation:  
  ```bash
  docker run --rm hello-world
  ```  