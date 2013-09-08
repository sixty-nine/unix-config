#!/bin/bash

source $BASEPATH/functions.sh
source $BASEPATH/aliases.sh
source $BASEPATH/colors.sh

[[ $(isInstalled vagrant) == 0 ]] && {
  source $BASEPATH/vagrant-aliases.sh
}

