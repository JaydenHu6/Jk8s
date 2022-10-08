#!/bin/bash

# 安装 docker
# ref: https://docs.docker.com/engine/install/centos/
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker.service
sudo systemctl stop docker
sudo cat ~/jk8s/conf/daemon.json | tee /etc/docker/daemon.json
sudo systemctl restart docker


