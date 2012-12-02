#!/bin/bash

function log() {
  LEVEL_COLOR=$1
  LEVEL_TEXT=$2
  MSG_COLOR=$3
  MSG_TEXT=$4

  echo -e "${LEVEL_COLOR:-$YELLOW}[${LEVEL_TEXT:-INFO}]${MSG_COLOR:-$NORMAL} ${MSG_TEXT}"
}

function log_info() {
  MESSAGE=$1
  log '' '' '' "$MESSAGE"
}

function log_error() {
  MESSAGE=$1
  log $RED 'ERROR' '' "$MESSAGE"
}

function isInstalled() {
  command -v $1 &>/dev/null; echo $?
}

function checkRequirement() {
  [[ $(isInstalled $1) == 0 ]] || {
    log_error "This program requires the '$1' application. Aborting."; exit 1;
  }
}

function notify() {
  [ $(isInstalled notify-send) == 0 ] && {
    notify-send -i $1 $2
  }
}

function cript() {
  openssl enc -aes-256-cbc -salt -in $1 -out $1.crypt
}

function decript() {
  openssl enc -aes-256-cbc -d -in ${1} -out ${1%.crypt}
}

