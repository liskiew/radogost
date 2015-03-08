#!/bin/bash

GREP=`which grep`
HEAD=`which head`
LS=`which ls`
SCP=`which scp`
SSH=`which ssh`
SORT=`which sort`
RM=`which rm`
UNIQ=`which uniq`
XARGS=`which xargs`

REMOTE_USER="$1"
REMOTE_HOST="$2"
REMOTE_PORT="$3"
REMOTE_PATH="$4"
FILEMASK="$5"
LOCAL_PATH="$6"
NUM_OF_LAST_FILES_REMAINING="$7"

### DO NOT EDIT BELOW THIS LINE ###

function print_usage() {
  echo "Usage: "
    echo "$0 [remote_user] [remote_host] [remote_port] [remote_path] [filemask] [local_path] [num_of_last_files_remaining]"
  }

function print_debug() {
  echo "Remote user: ${REMOTE_USER}"
  echo "Remote host: ${REMOTE_HOST}"
  echo "Remote port: ${REMOTE_PORT}"
  echo "Remote path: ${REMOTE_PATH}"
  echo "File mask: ${FILEMASK}"
  echo "Local path: ${LOCAL_PATH}"
  echo "Number of last files remaining: ${NUM_OF_LAST_FILES_REMAINING}"
}

if [ "x${NUM_OF_LAST_FILES_REMAINING}" == "x" ]; then
  print_usage
else
  if [ "${DEBUG}" == "true" ]; then
    print_debug
  fi
  LATEST_REMOTE_FILE=`${SSH} -p ${REMOTE_PORT} ${REMOTE_USER}@${REMOTE_HOST} "ls -1t ${REMOTE_PATH}/${FILEMASK} | head -1"`
  $SCP -P ${REMOTE_PORT} ${REMOTE_USER}@${REMOTE_HOST}:${LATEST_REMOTE_FILE} ${LOCAL_PATH}

  cd ${LOCAL_PATH}

  # Leave only n latest files
  (${LS} -1t ${FILEMASK} | ${HEAD} -n ${NUM_OF_LAST_FILES_REMAINING};${LS}) | ${SORT} | ${UNIQ} -u | ${XARGS} ${RM}

fi
