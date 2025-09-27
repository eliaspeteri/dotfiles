# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
# Credits to Derek Taylor for parts of the configuration.
#
#

export TERM="st-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -| cd..)"
# Use powerline
USE_POWERLINE="true"
# ZSH theme
ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
source $ZSH/oh-my-zsh.sh
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

findandkill() {
    port=$(lsof -n -i4TCP:$1 | grep LISTEN | awk '{ print $2 }') 
    kill -9 $port
}
alias killport=findandkill

alias b64decode='pbpaste | base64 --decode | pbcopy'
alias b64encode='pbpaste | base64 | pbcopy'

alias l="ls -lah --color=auto"
alias vimb="tabbed -c vimb -e"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

# Changing "ls" to "exa"
#alias ls='exa -al --color=always --group-directories-first'
#alias la='exa -a --color=always --group-directories-first'
#alias ll='exa -l --color=always --group-directories-first'
#alias lt='exa -aT --color=always --group-directories-first'
#alias l.='exa -a | egrep "^\."'

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

alias gst='git stash'
alias gsta='gst apply'
alias gs='git switch'
alias gc='git commit -m $1'
alias gp='git push'
alias gpu='git pull'
alias gpr='gpu --rebase'
alias gcp='gc $1 && gp'
alias gr='git rebase'
alias gri='gr -i'
alias gfp='gp --force-with-lease'
alias gpf='gfp'
alias gt='git tag'
alias gft='gt -f'
alias gtf='gft'
alias gl='git log --all --decorate --oneline --graph'
alias lg='lazygit'
alias findtag='gl | grep tag: '
alias gbprune="git fetch -p && git branch -vv | grep ': gone]' | grep -v "\*" | awk '{print $1; }' | xargs -r git branch -D"

alias deploy="deploy_env() { gft \"\$1\" && gp -f origin \"\$1\"; }; deploy_env"
alias dpre="deploy preview"
alias dprod="deploy production"
alias ddocs="deploy documentation"


export GITHUB_TOKEN="b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZWQyNTUxOQAAACAKj4awlpQKS6nYtE31TSIYhvWw15Jo4akuqckmR2LT2wAAAKjl81c65fNXOgAAAAtzc2gtZWQyNTUxOQAAACAKj4awlpQKS6nYtE31TSIYhvWw15Jo4akuqckmR2LT2wAAAEA8c3F8frCrGcNqkcGriHBI/v2+HugcMZ2pDESZ8w8oMgqPhrCWlApLqdi0TfVNIhiG9bDXkmjhqS6pySZHYtPbAAAAH2VsaWFzLnBldGVyaStnaXRodWJAaG90bWFpbC5jb20BAgMEBQY="

#source /usr/share/nvm/init-nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/nvm/init-nvm.sh
