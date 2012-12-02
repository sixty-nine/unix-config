#!/bin/bash

function color {
  printf "\e[38;05;$1m";
}

ESCAPE="\\033"

GREEN="${ESCAPE}[1;32m"
NORMAL="${ESCAPE}[0;39m"
RED="${ESCAPE}[1;31m"
PURPLE="${ESCAPE}[1;35m"
BLUE="${ESCAPE}[1;34m"
WHITE="${ESCAPE}[0;02m"
BLACK="${ESCAPE}[1;30m"
YELLOW="${ESCAPE}[1;33m"
CYAN="${ESCAPE}[1;36m"

BG_BLACK="${ESCAPE}[40m"
BG_RED="${ESCAPE}[41m"
BG_GREEN="${ESCAPE}[42m"
BG_YELLOW="${ESCAPE}[43m"
BG_BLUE="${ESCAPE}[44m"
BG_PURPLE="${ESCAPE}[45m"
BG_CYAN="${ESCAPE}[46m"
BG_WHITE="${ESCAPE}[47m"

BOLD_ON="${ESCAPE}[1m"
BOLD_OFF="${ESCAPE}[22m"


if [[ $1 = 'show' ]]; then

  echo 
  echo "SHELL COLORS"
  echo
  echo -e ${RED}'#####' RED
  echo -e ${GREEN}'#####' GREEN 
  echo -e ${YELLOW}'#####' YELLOW
  echo -e ${BLUE}'#####' BLUE
  echo -e ${PURPLE}'#####' PURPLE
  echo -e ${CYAN}'#####' CYAN
  echo -e ${WHITE}'#####' WHITE
  echo -e $NORMAL
  echo -e ${BG_RED}'#####' BG_RED$NORMAL
  echo -e ${BG_GREEN}'#####' BG_GREEN$NORMAL
  echo -e ${BG_YELLOW}'#####' BG_YELLOW$NORMAL
  echo -e ${BG_BLUE}'#####' BG_BLUE$NORMAL
  echo -e ${BG_PURPLE}'#####' BG_PURPLE$NORMAL
  echo -e ${BG_CYAN}'#####' BG_CYAN$NORMAL
  echo -e ${BLACK}${BG_WHITE}'#####' BG_WHITE$NORMAL
  echo 
  echo -e ${BOLD_ON}'#####' BOLD_ON/BOLD_OFF
  echo -e $NORMAL'#####' NORMAL
  echo 
elif [[ $1 = 'table' ]]; then
  printf '\n\e[38;05;255mCOLOR TABLE\n===========\n'
  for c in {0..255} ; do
    printf '\e[38;05;%sm%3s ' $c $c
    if [[ $(expr $c % 15) -eq 0 ]]; then
      echo ""
    fi
  done
  
  printf "\necho -e \"\\\e[38;05;<COLOR>m\"\n"
  printf "echo \$(color <COLOR>)\n\n"
fi
