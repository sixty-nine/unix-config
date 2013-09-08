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

# ----- Read the VirtualHost name

echo -n -e "${YELLOW}Enter the virtual host name: ${NORMAL}"
read VHOST

[[ $(ls -1 $VHOST_PATH | grep $VHOST &>/dev/null; echo $?) == 1 ]] || {
  log_error "The virtual host $VHOST alread exists"
  exit
}

[[ $(grep [[:space:]]$VHOST$ $HOSTS_FILE &>/dev/null; echo $?) == 1 ]] || {
  log_error "The virtual host is already in /ets/hosts"
  exit
}

# ----- Read the path containing the website

echo -n -e "${YELLOW}Enter the path to the site: ${NORMAL}"
read SITEPATH

if [ ! -d $SITEPATH ]; then
  log_error "Path not found $SITEPATH"
  exit
fi

# ----- Create the virtual host and add it to the known hosts

echo 

log_info "Creating file $VHOST_PATH$VHOST"
cat assets/vhost.asset | m4 -DSITEPATH=$SITEPATH | m4 -DVHOSTNAME=$VHOST > $VHOST_PATH$VHOST

log_info "Inserted alias $VHOST into $HOSTS_FILE"
echo -e "127.0.0.1\t$VHOST" >> $HOSTS_FILE

log_info "Done"

