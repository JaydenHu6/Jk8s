#!/bin/bash

source ./remote_env.sh
# 执行用户
HOST_USER="root"
# 私钥地址
PRIVATE_KEY="/Users/jayden/.ssh/cloud_rsa"

chmod +x ./*.sh

# master 上执行
function execute_on_master() {
    for rhost in $(cat ../conf/master_host);
    do
      echo "execute command on ${rhost}"
      echo "command is '${CUS_COMMAND}'"
      ssh -i ${PRIVATE_KEY} ${HOST_USER}@${rhost} "${CUS_COMMAND}"
    done
}

# node 上执行
function execute_on_node() {
    for rhost in $(cat ../conf/node_hosts);
    do
      echo "execute command on ${rhost}"
      echo "command is '${CUS_COMMAND}'"
      ssh -i ${PRIVATE_KEY} ${HOST_USER}@${rhost} "${CUS_COMMAND}"
    done
}

function execute_on_all() {
    execute_on_master
    execute_on_all
}

# 同步到 master
function rsync_on_master() {
   for rhost in $(cat ../conf/master_host);
   do
     echo "rsync on ${rhost}"
     rsync -e "ssh -i ${PRIVATE_KEY}" -P -r ../ "${HOST_USER}@${rhost}:~/jk8s"
   done
}

# 同步到节点
function rsync_on_node() {
   for rhost in $(cat ../conf/node_hosts);
   do
     echo "rsync on in ${rhost}"
     rsync -e "ssh -i ${PRIVATE_KEY}" -P -r ../ "${HOST_USER}@${rhost}:~/jk8s"
   done
}

function rsync_on_all() {
    rsync_on_master
    rsync_on_node
}

function func_exe(){
  local COMMAND=${@}
  echo "${@}"
}

