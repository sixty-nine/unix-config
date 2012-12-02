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

