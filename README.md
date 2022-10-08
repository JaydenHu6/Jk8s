# Jk8s Docker
 Jk8s 是用来一键化安装 k8s 集群，减少学习成本，容器运行时基于 docker, 由于 k8s v1.24 起不再支持 cri-dockerd,
 所以选择 k8s v1.23.6 进行安装，你可以选择一步一步手动安装，也可以选择一键化安装，但都需要先配置公钥、私钥、主节点ip，从节点ip
 ，这些信息是必要的。

## 环境信息
- CentOS 7.9
- Kubernetes v1.23.6

## A. 手动安装
### 1. 前提准备
1. 本地执行 `sh local_install_k8s_packages.sh` 下载依赖包
2. 为每个机器配置本地机器的公钥
3. 在 `local_env.sh` 中配置本地机器私钥绝对路径
4. 将 k8s master 机器的 ip 配置到 `conf/master_host` 中
5. 将 k8s node 机器的 ip 配置到 `conf/node_hosts` 中

### 2. K8S Master 节点部署
1. 本地机器执行 `sh local_rsync_packages.sh master` 将包上传到 master 节点中
2. 本地机器执行 `sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_install.sh" master` 安装 docker 以及 k8s component
3. 本地机器执行 `sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_master_exe.sh" master` 初始化集群
4. 本地机器执行 `sh local_execute_remote_command.sh "kubeadm token create --print-join-command" master | grep "kubeadm join" | tee kubeadm_node_join.sh` 获取token
5. 本地机器执行 `sh local_rsync_remote_admin_conf.sh` 将 master 节点中的 admin.conf 文件复制到本地

### 3. K8S Node 节点部署
1. 本地机器执行 `sh local_rsync_packages.sh node` 将包上传到节点中
2. 本地机器执行 `sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_install.sh" node` 安装 docker 以及 k8s component
3. 本地机器执行 `sh local_execute_remote_command.sh "sh ~/jk8s/script/remote_node_exe.sh" node` 将节点加入到集群中

### 4. 配置集群
1. 本地机器执行 `sh remote_init.sh` 配置集群

## B. 一键安装
1. 为每个机器配置本地机器的公钥
2. 在 `local_env.sh` 中配置本地机器私钥绝对路径
3. 将 k8s master 机器的 ip 配置到 `conf/master_host` 中
5. 将 k8s node 机器的 ip 配置到 `conf/node_hosts` 中
4. 执行 `sh install.sh`一键化安装