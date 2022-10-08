#!/bin/bash

# 安装 k8s 组件
# env
source ~/jk8s/script/remote_env.sh

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum clean all
yum makecache fast
yum install kubernetes-cni -y

# 安装
echo "==> install cni"
sudo tar -C /opt/cni/bin -xzf ~/jk8s/packages/cni-plugins-linux-${ARCH}-${CNI_VERSION}.tgz

echo "==> mkdir local bin"
DOWNLOAD_DIR=/usr/local/bin
sudo mkdir -p $DOWNLOAD_DIR

echo "==> install cri-tools"
sudo tar -C $DOWNLOAD_DIR -xzf  ~/jk8s/packages/crictl-${CRICTL_VERSION}-linux-${ARCH}.tar.gz

echo "==> install kubeadm kubelet kubectl"
sudo chmod +x ~/jk8s/packages/kubeadm
sudo install -o root -g root -m 0755 ~/jk8s/packages/kubeadm /usr/local/bin/kubeadm
sudo chmod +x ~/jk8s/packages/kubelet
sudo install -o root -g root -m 0755 ~/jk8s/packages/kubelet /usr/local/bin/kubelet
sudo chmod +x ~/jk8s/packages/kubectl
sudo install -o root -g root -m 0755 ~/jk8s/packages/kubectl /usr/local/bin/kubectl


echo "==> add kubelet service"
sed "s:/usr/bin:${DOWNLOAD_DIR}:g" ~/jk8s/packages/kubelet.service | sudo tee /etc/systemd/system/kubelet.service
sudo mkdir -p /etc/systemd/system/kubelet.service.d
sed "s:/usr/bin:${DOWNLOAD_DIR}:g" ~/jk8s/packages/10-kubeadm.conf | sudo tee /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

echo "==> add kubelet to systemctl"
systemctl enable --now kubelet

echo "==> install socat conntrack-tools flannel"
yum -y install socat conntrack-tools flannel




