#!/bin/bash

# 初始化集群
kubeadm init --image-repository registry.aliyuncs.com/google_containers \
            --pod-network-cidr=10.244.0.0/16
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f ~/jk8s/conf/kube-flannel.yml
kubectl get nodes
kubectl get pods --all-namespaces