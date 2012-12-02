#!/bin/bash

source $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/includes.sh

checkRequirement toilet
checkRequirement fortune

FONT=smbraille

echo -e $PURPLE;toilet -t -f $FONT "Welcome to $(hostname)"
echo -e $BLUE $(uname -s) $(uname -r) 
echo -e $NORMAL
fortune -s
echo
echo

