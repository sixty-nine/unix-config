#!/bin/bash

function isInstalled() {
  command -v $1 &>/dev/null; echo $?
}

function checkRequirement() {
  [[ $(isInstalled $1) == 0 ]] || {
    echo -e $RED"This program requires the '$1' application. Aborting."$NORMAL >&2; exit 1;
  }
}

function notify() {
  [ $(isInstalled notify-send) == 0 ] && {
    notify-send -i $1 $2
  }
}

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
