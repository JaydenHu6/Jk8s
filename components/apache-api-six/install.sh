#!/bin/bash
cd ../../script
sh ./local_execute_remote_command.sh "mkdir -p /data/k8s/apisix/etcd/"
sh ./local_execute_remote_command.sh "chmod +777 /data/k8s/apisix/etcd/"
sh ./local_execute_remote_command.sh "kubectl apply -f ~/jk8s/components/apache-api-six/etcd.yml"
sh ./local_execute_remote_command.sh "kubectl apply -f ~/jk8s/components/apache-api-six/apisix.yml"
sh ./local_execute_remote_command.sh "kubectl apply -f ~/jk8s/components/apache-api-six/apisix-dashboard.yml"