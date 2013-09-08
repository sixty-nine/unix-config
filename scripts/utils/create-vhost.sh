#!/bin/bash

#set -x

export BASEPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASEPATH=$( dirname $BASEPATH )
source $BASEPATH/includes.sh

if [[ $(id -u) != 0 ]]; then
  log_error "This script must be run as root"
  exit
fi

VHOST_PATH=/etc/apache2/sites-available/
HOSTS_FILE=/etc/hosts
VHOST_TEMPLATE=$BASEPATH/templates/vhost.template

function readVirtualHost() {
  echo -n -e "${YELLOW}Enter the virtual host name: ${NORMAL}"
  read VHOST
}

function readWebsitePath() {
  echo -n -e "${YELLOW}Enter the path to the site: ${NORMAL}"
  read SITEPATH
}

function checkVirtualHost() {
  [[ $(ls -1 $VHOST_PATH | grep ^$VHOST$ &>/dev/null; echo $?) == 1 ]] || {
    log_error "The virtual host $VHOST alread exists"
    exit
  }

  [[ $(grep [[:space:]]$VHOST$ $HOSTS_FILE &>/dev/null; echo $?) == 1 ]] || {
    log_error "The virtual host is already in /ets/hosts"
    exit
  }
}

function checkWebsitePath() {
  if [ -z "$SITEPATH" ]; then
    log_error "Path not given"
    exit
  fi

  if [ ! -d $SITEPATH ]; then
    log_error "Path not found $SITEPATH"
    exit
  fi
}

if [ "$#" == 0 ]; then
  readVirtualHost
  readWebsitePath
else
  VHOST=$1
  SITEPATH=$2
fi

checkVirtualHost
checkWebsitePath

# ----- Create the virtual host and add it to the known hosts

echo 

log_info "Creating file $VHOST_PATH$VHOST"
cat $VHOST_TEMPLATE | m4 -DSITEPATH=$SITEPATH | m4 -DVHOSTNAME=$VHOST > $VHOST_PATH$VHOST

log_info "Inserted alias $VHOST into $HOSTS_FILE"
echo -e "127.0.0.1\t$VHOST" >> $HOSTS_FILE

log_info "Enabling virtual host"
a2ensite $VHOST &>/dev/null
service apache2 reload &>/dev/null

log_info "Done"

