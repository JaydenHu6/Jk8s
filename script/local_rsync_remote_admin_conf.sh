#!/bin/bash

source ./local_env.sh
source ./remote_env.sh

MASTER_HOST=$(head -n 1 ../conf/master_host)
rsync -e "ssh -i ${PRIVATE_KEY}" -P  "${HOST_USER}@${MASTER_HOST}:/etc/kubernetes/admin.conf" ../conf/admin.conf
