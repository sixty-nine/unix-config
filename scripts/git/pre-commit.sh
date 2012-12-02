#!/bin/bash

# Install: ln -s /home/dan/scripts/test/pre-commit.sh .git/hooks/pre-commit

source $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../includes.sh

RESULT=0

[[ $(isInstalled jslint) == 0 ]] && {

  echo
  echo -e $(color 240)"===$(color 230) JSLinting $(color 240)==============================================================$NORMAL"
  echo

  $BASEPATH/git/pre-commit-tests/jslint.sh

  RESULT=$?
  
  if [ $RESULT == 1 ]; then
    notify error "JSLint failed"
  else
    echo -e $GREEN"OK"$NORMAL
  fi

  echo
}

[[ $(isInstalled phpcs) == 0 ]] && {

  echo
  echo -e $(color 240)"===$(color 230) PHPCS $(color 240)==================================================================$NORMAL"
  echo

  $BASEPATH/git/pre-commit-tests/phplint.sh

  RESULT=$?
  if [ $RESULT == 1 ]; then
    notify error "PHPCS failed"
  else
    echo -e $GREEN"OK"$NORMAL
  fi

  echo
}


if [ $RESULT == 1 ]; then
  echo
  echo -e $RED"Sorry I cannot commit this unless you use the '--no-verify' option"$NORMAL
fi

echo
exit $RESULT

