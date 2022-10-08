#!/bin/bash

source ./local_env.sh
CUS_COMMAND=${1}
EXECUTE_TYPE=${2-all}

case ${EXECUTE_TYPE} in
  "all")
    execute_on_master
    execute_on_node
  ;;
  "master")
    execute_on_master
  ;;
  "node")
    execute_on_node
  ;;
esac