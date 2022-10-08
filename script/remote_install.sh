#!/bin/bash

source ~/jk8s/script/remote_env.sh

echo "==> config network"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
# 开启 ipv4 ip 转发
sysctl -w net.ipv4.ip_forward=1

echo "==> install docker"
bash ~/jk8s/script/remote_install_docker.sh
echo "==> install k8s components"
bash ~/jk8s/script/remote_install_k8s_components.sh