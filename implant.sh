#!/bin/bash

SETUP_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) 
HOME_DIR=~/
BASEPATH=$SETUP_PATH/scripts

source $SETUP_PATH/scripts/includes.sh

# ----- INSTALL DEPENDENCIES

log_info "Installing dependencies..."

sudo apt-get install -y -qq toilet toilet-fonts
sudo apt-get install -y -qq fortune-mod fortunes

# ------ VIM

log_info "Setting up vim..."

sudo apt-get install -y -qq vim vim-common vim-runtime

cp -R $SETUP_PATH/assets/vim/vim $HOME_DIR/.vim
cp $SETUP_PATH/assets/vim/vimrc $HOME_DIR/.vimrc

cd $HOME_DIR/.vim/bundle
git clone git://github.com/tpope/vim-fugitive.git
git clone https://github.com/scrooloose/nerdtree.git

# ----- GIT

log_info "Setting up git..."

cp $SETUP_PATH/assets/git/gitconfig $HOME_DIR/.gitconfig

# ----- CUSTOM SCRIPTS

log_info "Setting up custom scripts..."

cp -R $SETUP_PATH/scripts $HOME_DIR

# ----- IMPLANT IN BASHRC

log_info "Implanting custom scripts..."

if [ ! -f $HOME_DIR/.bashrc ]; then
  touch $HOME_DIR/.bashrc
fi

tail $HOME_DIR/.bashrc | grep "source .*/scripts/startup.sh" > /dev/null || { 
  echo "source $HOME_DIR/scripts/startup.sh" >> $HOME_DIR/.bashrc
}

