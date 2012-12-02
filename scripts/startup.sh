#!/bin/bash

#set -x

export BASEPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $BASEPATH/includes.sh

# ----- Prompt color: RED for root, BLUE for local user

if [[ $(id -u) == 0 ]]; then
  PROMPT_COL="$RED"
else
  PROMPT_COL="$CYAN"
fi

PS1="\[$PROMPT_COL\]${debian_chroot:+($debian_chroot)}\u@\h \[$YELLOW\][\w]\[$NORMAL\]\[$NORMAL\]: "

# ----- Variables

export EDITOR=/usr/bin/vim

# ----- Show logo
$BASEPATH/logo.sh

