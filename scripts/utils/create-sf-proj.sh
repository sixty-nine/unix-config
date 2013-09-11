#!/bin/bash

export BASEPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASEPATH=$( dirname $BASEPATH )
source $BASEPATH/includes.sh

PRJ_HOME=$1
if [ -z "$PRJ_HOME" ]; then
  log_error "Project path not given"
  exit
fi

if [ -d $PRJ_HOME ]; then
  log_error "Project path already exists $PRJ_HOME"
  exit
fi

# http://symfony.com/download?v=Symfony_Standard_2.2.0.tgz  
# http://symfony.com/download?v=Symfony_Standard_2.2.6.tgz
# http://symfony.com/download?v=Symfony_Standard_2.3.4.tgz

SYMFONY_URL=http://symfony.com/download?v=Symfony_Standard_2.3.4.tgz

TEMP_FILE=$( tempfile )

# ----- Create the project dir and download Symfony
log_info "Create project dir $PRJ_HOME"
mkdir -p $PRJ_HOME
cd $PRJ_HOME

log_info "Download and extract Symfony"
wget $SYMFONY_URL -O $TEMP_FILE &>/dev/null
tar --strip-components=1 -xvzf $TEMP_FILE &>/dev/null
rm $TEMP_FILE

# ----- Cache and logs dirs rights
log_info "Set app/cache and app/logs dir permissions"
log_warning "The script need root access to modify the permissions (^C twice to ignore step)"
APACHEUSER=`ps aux | grep -E '[a]pache|[h]ttpd' | grep -v root | head -1 | cut -d\  -f1`
sudo setfacl -R -m u:$APACHEUSER:rwX -m u:`whoami`:rwX app/cache app/logs
sudo setfacl -dR -m u:$APACHEUSER:rwX -m u:`whoami`:rwX app/cache app/logs

# ----- Remove ACME bundle
rm -rf src/Acme
cp $BASEPATH/templates/routing_dev.yml.template app/config/routing_dev.yml
sed '/AcmeDemoBundle/d' app/AppKernel.php > app/AppKernel.tmp
rm app/AppKernel.php
mv app/AppKernel.tmp app/AppKernel.php

# ----- Install Symfony vendors and assets
log_info "Install vendors and assets"
sed '/"extra"/a \\t"symfony-assets-install": "symlink",' composer.json > composer.tmp
rm composer.json
mv composer.tmp composer.json
composer.phar update &>/dev/null

# ----- Git
log_info "Setup GIT"
git init &>/dev/null
cp $BASEPATH/templates/gitignore.template .gitignore
git add .
git ci -m "Initial import" &>/dev/null


