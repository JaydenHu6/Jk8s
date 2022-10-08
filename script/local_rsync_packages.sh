#!/bin/bash

source ./local_env.sh

EXECUTE_TYPE=${1-all}

case ${EXECUTE_TYPE} in
  "all")
    rsync_on_master
    rsync_on_node
  ;;
  "master")
    rsync_on_master
  ;;
  "node")
    rsync_on_node
  ;;
esac