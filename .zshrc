# Credits to Derek Taylor for parts of the configuration.
#
#

export TERM="st-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -| cd..)"
# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

alias l="ls -lah --color=auto"
alias vimb="tabbed -c vimb -e"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

# pacman and yay
alias pacsyu='sudo pacman -Syyu'		# update only standard pkgs
alias yaysua='yay -Sua --noconfirm'		# update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'		# update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm'		# update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'		# update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'	# remove pacman lock

# faster mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# adding flags
alias df='df -h'
alias free='free -m'
alias vifm='./.config/vifm/scripts/vifmrun'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status' # status is a protected name
alias tag='git tag'
alias newtag='git tag -a'

source /usr/share/nvm/init-nvm.sh

### BASH INSULTER ###
if [ -f /etc/bash.command-not-found ]; then
	./etc/bash.command-not-found
fi

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tool
