#!/bin/bash
alias vg-create="vagrant init debian && vagrant up && vagrant ssh"
alias vg-up="vagrant up && vagrant ssh"
alias vg-stat="vagrant status"
alias vg-down="vagrant halt"
alias vg-destroy="vagrant halt && vagrant destroy"

