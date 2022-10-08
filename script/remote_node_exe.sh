#!/bin/bash
cat ~/jk8s/conf/admin.conf | tee /etc/kubernetes/admin.conf
echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> /etc/bashrc
source /etc/bashrc
bash ~/jk8s/script/kubeadm_node_join.sh