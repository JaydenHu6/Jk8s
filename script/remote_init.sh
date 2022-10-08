#!/bin/bash

# (node) 将 conf/admin.conf 移动到 /etc/kubernetes/admin.conf
sh ./local_execute_remote_command.sh "cat ~/jk8s/conf/admin.conf | tee /etc/kubernetes/admin.conf" node
# (all) 将 KUBECONFIG 添加到 /etc/bashrc 中
sh ./local_execute_remote_command.sh "echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> /etc/bashrc" all