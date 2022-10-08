#!/bin/bash

# k8s 依赖包下载脚本
# 用户本地下载包然后将下载好的包传到服务器上

# env
source ./local_env.sh

echo "==> install cni"
curl -L "https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-${ARCH}-${CNI_VERSION}.tgz" -o ../packages/cni-plugins-linux-${ARCH}-${CNI_VERSION}.tgz
echo "==> install circtl"
curl -L "https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-${ARCH}.tar.gz" -o ../packages/crictl-${CRICTL_VERSION}-linux-${ARCH}.tar.gz
echo "==> install kubectl"
curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${RELEASE}/bin/linux/${ARCH}/kubectl -o ../packages/kubectl
echo "==> install kubeadm"
curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${RELEASE}/bin/linux/${ARCH}/kubeadm -o ../packages/kubeadm
echo "==> install kubelet"
curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${RELEASE}/bin/linux/${ARCH}/kubelet -o ../packages/kubelet
echo "==> install kubelet.service"
curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service" -o ../packages/kubelet.service
echo "==> install kubeadm.cnf"
curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf" -o ../packages/10-kubeadm.conf
#echo "==> package"
#zip -o ../../jk8s_centos7 -r ../../jk8s_centos7
echo "==> success!"
