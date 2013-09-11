#!/bin/bash

function log() {
  LEVEL_COLOR=$1
  LEVEL_TEXT=$2
  MSG_COLOR=$3
  MSG_TEXT=$4

  echo -e "${LEVEL_COLOR:-$GREEN}[${LEVEL_TEXT:-INFO}]${MSG_COLOR:-$NORMAL} ${MSG_TEXT}"
}

function log_info() {
  MESSAGE=$1
  log '' '' '' "$MESSAGE"
}

function log_warning() {
  MESSAGE=$1
  log $YELLOW 'WARNING' '' "$MESSAGE"
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
  INFILE=$1
  OUTFILE=$2
  openssl enc -aes-256-cbc -salt -in $INFILE -out $OUTFILE
}

function decript() {
  INFILE=$1
  OUTFILE=$2
  openssl enc -aes-256-cbc -d -in $INFILE -out $OUTFILE
}

function backup() {
  TMPFILE=$(mktemp)
  read -p "Enter password: " PASSWORD
  tar cvzf $TMPFILE $1
  openssl enc -pass pass:$PASSWORD -aes-256-cbc -salt -in $TMPFILE -out $(basename $1).bak
  rm $TMPFILE
}

function restore() {
  INFILE=$1
  openssl enc -d -aes-256-cbc -salt -in $INFILE | tar xvz
}

