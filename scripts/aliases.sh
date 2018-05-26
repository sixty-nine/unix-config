#!/bin/bash
alias la="ls -lahF"
alias ll="ls -lhF"
alias l="ls -lhF"

alias df='df -h'

alias untar='tar xvf'
alias untarz='tar xvzf'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..="cd .."

alias cdd='cd /home/dev'
alias gitst='git st'
alias gitci='git ci'

alias usage='du --max-depth=1 --block-size=MiB | sort -n -r | head -25'
alias ddu='du -sh */ 2> /dev/null | sort -hr'

alias myip='dig +short my.ip @outsideip.net'

alias phpinfo='php -r "phpinfo();"'

alias dmesg='dmesg -T'

# Force git to run in englsh
alias git='LANGUAGE=en_US.UTF-8 git'
