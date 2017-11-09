alias tu="sudo sysctl debug.lowpri_throttle_enabled=0"
alias pgup="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgdown="pg_ctl -D /usr/local/var/postgres stop"
alias mongod="ulimit -n 4096 && mongod"

# Git
alias gs="git status"
alias gc="git checkout ."
alias gb="git branch"

# Xcode
alias xc-rm="""
rm -rf ${HOME}/Library/Developer/Xcode/DerivedData 
rm -rf ${HOME}/Library/Developer/Xcode/Archives 
rm -rf ${HOME}/Library/Developer/Xcode/Products
"""

export CLICOLOR=1
export LSCOLORS=BxFxCxDxBxegedabagaced # For dark background

export PATH="$HOME/.npm-packages/bin:$PATH"
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM

RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[0;37m\]'
RESET="\[\e[0m\]"

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="${GREEN}\w"
PS1+="${RED}\$(git_branch) ${GREEN}"
PS1+="›${YELLOW}›${RED}›"; # Working directory full path
PS1+="${WHITE} ${RESET}"; # Reset

export PS1;
export PS2="\[${GREEN}\]›\[\033[m\] " # Secondary prompt

# Goes up a certain amount of directories
# Usage: up 2
function up() {
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

function powup() {
	launchctl load ~/Library/LaunchAgents/cx.pow.powd.plist
	sudo launchctl load /Library/LaunchDaemons/cx.pow.firewall.plist
}

function powdown() {
	launchctl unload ~/Library/LaunchAgents/cx.pow.powd.plist
	sudo launchctl unload /Library/LaunchDaemons/cx.pow.firewall.plist
}

[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # AVN
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # NVM

if [ -f .secrets ]; then
	source .secrets
fi

# RVM
source ~/.rvm/scripts/rvm
