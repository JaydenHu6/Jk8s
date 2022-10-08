#!/bin/bash

# 1. 下载包
sh local_install_k8s_packages.sh

# 2. master 初始化
sh local_rsync_packages.sh master
sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_install.sh" master
sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_master_exe.sh" master
sh local_execute_remote_command.sh "kubeadm token create --print-join-command" master | grep "kubeadm join" | tee kubeadm_node_join.sh
sh local_rsync_remote_admin_conf.sh

# 3. node 初始化
sh local_rsync_packages.sh node
sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_install.sh" node
sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_node_exe.sh" node

# 4. 初始化集群
sh remote_init.sh