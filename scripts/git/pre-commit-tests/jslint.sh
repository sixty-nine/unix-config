#!/bin/bash

RES=0

for FILE in $(git diff-index --name-status HEAD -- | cut -c3-); do
  if [[ $FILE == *.js ]]; then
    jslint $FILE | grep '#[0-9]* \|^[^\.]*\.js$'
    if [ $? == 0 ]; then
      RES=1
    fi
  fi
done

exit $RES

