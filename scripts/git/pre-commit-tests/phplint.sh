#!/bin/bash

RES=0

for FILE in $(git diff-index --name-status HEAD -- | cut -c3-); do
  if [[ $FILE == *.php ]]; then
    phpcs -s --standard=Symfony2 $FILE | grep '^FILE\|^FOUND'
    if [ $? == 1 ]; then
      RES=1
    fi
  fi
done

exit $RES

