#!/bin/bash

source $BASEPATH/functions.sh
source $BASEPATH/aliases.sh
source $BASEPATH/colors.sh

[[ $(isInstalled vagrant) == 0 ]] && {
  source $BASEPATH/vagrant-aliases.sh
}

[[ $(isInstalled apache2) == 0 ]] && {
  source $BASEPATH/apache2-aliases.sh
}

