#!/bin/bash
alias la="ls -lahF"
alias ll="ls -lhF"
alias l="ls -lhF"

alias df='df -h'
alias free='free -h'

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

alias shutdown='sudo shutdown -h now'
alias hibernate='sudo systemctl hibernate'

alias dmesg='dmesg -T'

alias gti='git'
alias nvmi='nvm i'
alias nvmu='nvm use'

alias acs='apt-cache search'

alias serv-running='sudo service --status-all | grep \ +'
alias serv-stopped='sudo service --status-all | grep \ -'
alias serv-stop='sudo systemctl stop'
alias serv-start='sudo systemctl start'
alias serv-status='sudo systemctl status'
alias serv-disable='sudo systemctl disable'
alias serv-enable='sudo systemctl enable'

alias scanim='for i in {01..20}.png ; do scrot -s $i ; echo $i ; done ; convert -delay 50 {01..20}.png -layers Optimize anim.gif'

alias rrm='shred -zvu -n  5'


