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
alias churn="git log --all -M -C --name-only --format='format:' "$@" | sort | grep -v '^$' | uniq -c | sort | awk 'BEGIN {print "count\tfile"} {print $1 "\t" $2}' | sort -g"

alias deploy="deploy_env() { gft \"\$1\" && gp -f origin \"\$1\"; }; deploy_env"
alias dpre="deploy preview"
alias dprod="deploy production"
alias ddocs="deploy documentation"


export GITHUB_TOKEN="b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZWQyNTUxOQAAACAKj4awlpQKS6nYtE31TSIYhvWw15Jo4akuqckmR2LT2wAAAKjl81c65fNXOgAAAAtzc2gtZWQyNTUxOQAAACAKj4awlpQKS6nYtE31TSIYhvWw15Jo4akuqckmR2LT2wAAAEA8c3F8frCrGcNqkcGriHBI/v2+HugcMZ2pDESZ8w8oMgqPhrCWlApLqdi0TfVNIhiG9bDXkmjhqS6pySZHYtPbAAAAH2VsaWFzLnBldGVyaStnaXRodWJAaG90bWFpbC5jb20BAgMEBQY="

#source /usr/share/nvm/init-nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/nvm/init-nvm.sh

# AWS SecretsManager YAML CLI helper
aws_secret_tool() {
  if [[ $# -lt 2 ]]; then
    echo "Usage:"
    echo "  aws_secret_tool grep <secret-id> <search-terms...>           - Grep through inlined YAML"
    echo "  aws_secret_tool dump <secret-id>                             - Pretty-print YAML"
    echo "  aws_secret_tool update <secret-id> [<file>|--stdin]          - Update secret (from file or stdin)"
    echo "  aws_secret_tool restore <secret-id> <backup-file.yaml>       - Restore a secret from a local backup"
    return 1
  fi

  local cmd=$1
  shift

  case "$cmd" in
    grep)
      local secret_id=$1
      shift
      local search_pattern=$(printf "%s|" "$@" | sed 's/|$//')

      aws secretsmanager get-secret-value --secret-id "$secret_id" \
        --query SecretString --output text 2>/dev/null | \
        sed -E 's/([a-zA-Z0-9_-]+:)/\n\1/g' | \
        sed -E 's/^[ ]+//' | \
        grep -iE --color=always "$search_pattern"
      ;;

    dump)
      local secret_id=$1
      aws secretsmanager get-secret-value --secret-id "$secret_id" \
        --query SecretString --output text 2>/dev/null | \
        yq -P
      ;;

    update)
      local secret_id=$1
      local input=$2
      local new_secret

      if [[ "$input" == "--stdin" ]]; then
        echo "Reading new secret value from stdin... (CTRL+D to end)"
        new_secret=$(cat)
      elif [[ -f "$input" ]]; then
        new_secret=$(<"$input")
      else
        echo "Invalid input. Provide a file or use --stdin."
        return 1
      fi

      # Validate YAML
      if ! echo "$new_secret" | yq e >/dev/null 2>&1; then
        echo "❌ Invalid YAML format. Update aborted."
        return 1
      fi

      # Backup existing secret
      local backup_file="${secret_id}_backup_$(date +%Y%m%d_%H%M%S).yaml"
      aws secretsmanager get-secret-value --secret-id "$secret_id" \
        --query SecretString --output text > "$backup_file" 2>/dev/null && \
        echo "🛡️  Backup saved to $backup_file"

      # Push new secret
      echo "✅ YAML is valid. Updating secret '$secret_id'..."
      aws secretsmanager update-secret --secret-id "$secret_id" \
        --secret-string "$new_secret" && echo "✅ Secret updated."
      ;;

    restore)
      local secret_id=$1
      local backup_file=$2

      if [[ ! -f "$backup_file" ]]; then
        echo "❌ Backup file not found: $backup_file"
        return 1
      fi

      local backup_content=$(<"$backup_file")

      # Validate YAML
      if ! echo "$backup_content" | yq e >/dev/null 2>&1; then
        echo "❌ Invalid YAML format in backup file. Restore aborted."
        return 1
      fi

      echo "Restoring '$secret_id' from backup file..."
      aws secretsmanager update-secret --secret-id "$secret_id" \
        --secret-string "$backup_content" && echo "✅ Secret restored from $backup_file."
      ;;

    *)
      echo "Unknown subcommand: $cmd"
      return 1
      ;;
  esac
}

# Create a GitHub release from the latest CHANGELOG.md section
# Usage:
#   gh_release_from_changelog [--dry-run] [--strict-exit] [--changelog PATH] [--repo owner/name]
gh_release_from_changelog() {
  emulate -L zsh
  setopt localoptions noerrexit nounset pipefail errreturn

  typeset -i DRY_RUN=0 STRICT=0 FAILED=0 DRAFT=0
  local CHANGELOG="CHANGELOG.md" REPO_OVERRIDE=""

  _err() { print -u2 -- "$@"; FAILED=1; }
  _need() { command -v "$1" >/dev/null 2>&1 || _err "❌ Required command '$1' not found in PATH."; }

  # Args
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)       DRY_RUN=1; shift ;;
      --strict-exit)   STRICT=1; shift ;;
      --changelog)     CHANGELOG="${2:-}"; shift 2 ;;
      -c)              CHANGELOG="${2:-}"; shift 2 ;;
      --changelog=*)   CHANGELOG="${1#*=}"; shift ;;
      --repo)          REPO_OVERRIDE="${2:-}"; shift 2 ;;
      --repo=*)        REPO_OVERRIDE="${1#*=}"; shift ;;
      --draft)         DRAFT=1; shift ;;
      -h|--help)
        cat <<'EOF'
Usage: gh_release_from_changelog [--dry-run] [--strict-exit] [--changelog PATH] [--repo owner/name]
Creates a GitHub release from the topmost changelog section. Matches both "##" and "###" headings.
EOF
        return 0 ;;
      *) _err "⚠️ Unknown arg: $1"; shift ;;
    esac
  done

  # Reqs
  _need jq; _need awk; _need sed; _need git
  [[ -f "$CHANGELOG" ]] || _err "❌ $CHANGELOG not found."
  if (( STRICT && FAILED )); then return $FAILED; fi

  # --- Parse header: accept both '## [' and '### [' (skip 'Unreleased')
  # ERE for grep/awk, BRE for sed:
  local HEADER_RE='^#{2,3} \[[0-9]'   # ERE (2 or 3 #'s then space then [digit)
  local header
  header="$(grep -m1 -E "$HEADER_RE" "$CHANGELOG" 2>/dev/null || true)"
  [[ -n "${header:-}" ]] || _err "❌ No release section found like '## [6.77.x] (...)' or '### [6.77.x] (...)'."

  # Extract fields from header; sed uses BRE, so quantifier is \{2,3\}
  local version range prev_tag curr_tag date_str
  if [[ -n "${header:-}" ]]; then
    version="$(printf '%s\n' "$header" | sed -n 's/^#\{2,3\} \[\([0-9][^]]*\)\].*/\1/p')"
    range="$(printf '%s\n' "$header" | sed -n 's/.*compare\/\([^)]*\)).*/\1/p')"   # vA...vB
    prev_tag="${range%%...*}"
    curr_tag="${range##*...}"
    date_str="$(printf '%s\n' "$header" | sed -n 's/.*(\([0-9-]\{10\}\)).*/\1/p')"
    [[ -n "${version:-}" && -n "${prev_tag:-}" && -n "${curr_tag:-}" && -n "${date_str:-}" ]] \
      || _err "❌ Failed to parse version/tags/date from header: $header"
  fi

  # Optional sanity
  if [[ -n "${curr_tag:-}" && -n "${version:-}" && "v${version}" != "${curr_tag}" ]]; then
    _err "⚠️ Tag ${curr_tag} does not match version v${version} from header."
  fi

  # Slice the top section (from first ##/### to the next ##/### or EOF)
  local section_file; section_file="$(mktemp -t rel_section.XXXXXX)"
  awk '
    BEGIN { p=0; count=0 }
    /^#{2,3} \[/ {
      count++
      if (count==1) { p=1; print; next }
      if (count==2) { exit }
    }
    p { print }
  ' "$CHANGELOG" > "$section_file" 2>/dev/null || _err "❌ Failed to capture top changelog section."

  # Git / tags
  if [[ -n "${curr_tag:-}" ]]; then
    if ! git rev-parse -q --verify "$curr_tag" >/dev/null 2>&1; then
      if ! git ls-remote --tags origin | grep -q "refs/tags/${curr_tag}\$"; then
        _err "❌ Tag $curr_tag not found locally or on origin. Push the tag first."
      fi
    fi
  fi
  if [[ -n "${prev_tag:-}" ]]; then
    if ! git rev-parse -q --verify "$prev_tag" >/dev/null 2>&1; then
      if ! git ls-remote --tags origin | grep -q "refs/tags/${prev_tag}\$"; then
        print -u2 "⚠️ Previous tag $prev_tag not found locally or on origin; will set anyway."
      fi
    fi
  fi

  # Repo resolution (override -> gh -> git remote)
  local repo=""
  if [[ -n "$REPO_OVERRIDE" ]]; then
    repo="$REPO_OVERRIDE"
  else
    if command -v gh >/dev/null 2>&1; then
      repo="$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)"
    fi
    if [[ -z "$repo" ]]; then
      local rurl; rurl="$(git config --get remote.origin.url 2>/dev/null || true)"
      if [[ "$rurl" == git@github.com:* ]]; then
        repo="${rurl#git@github.com:}"; repo="${repo%.git}"
      elif [[ "$rurl" == https://github.com/* ]]; then
        repo="${rurl#https://github.com/}"; repo="${repo%.git}"
      fi
    fi
  fi
  [[ -n "$repo" ]] || _err "❌ Could not determine GitHub repository (use --repo owner/name)."

  if (( STRICT && FAILED )); then
    rm -f "$section_file"
    return $FAILED
  fi

  # compute JSON-safe booleans/strings
  local DRAFT_JSON; DRAFT_JSON=$([[ $DRAFT -eq 1 ]] && echo true || echo false)
  # drafts cannot be “latest”; be explicit
  local MAKE_LATEST_JSON; MAKE_LATEST_JSON=$([[ $DRAFT -eq 1 ]] && echo '"false"' || echo '"true"')


  # Compose release title: "version (date)"
  local TITLE="${version} (${date_str})"

  # Payload
  local payload_file; payload_file="$(mktemp -t rel_payload.XXXXXX)"
  jq -n \
    --rawfile body "$section_file" \
    --arg tag  "${curr_tag:-}" \
    --arg name "${TITLE:-}" \
    --arg prev "${prev_tag:-}" \
    --argjson draft "$DRAFT_JSON" \
    --argjson make_latest "$MAKE_LATEST_JSON" \
    '{
      tag_name: $tag,
      name: $name,
      body: $body,
      draft: $draft,
      make_latest: $make_latest,
      previous_tag_name: $prev
    }' > "$payload_file" 2>/dev/null || _err "❌ Failed to build JSON payload."

  if (( DRY_RUN )); then
    print "🧪 Dry run: detected header:"
    print -- "$header"
    print "🧪 Dry run: would POST /repos/${repo}/releases with payload:"
    cat "$payload_file"
    rm -f "$section_file" "$payload_file"
    return 0
  fi

  # Create release (only if gh is available; otherwise error above would have fired)
  if command -v gh >/dev/null 2>&1 && (( ! FAILED )); then
    local out
    out="$(gh api -X POST -H "Accept: application/vnd.github+json" "/repos/${repo}/releases" --input "$payload_file" 2>&1)" || {
      _err "❌ GitHub API error:"; print -u2 -- "$out"
    }
    if (( ! FAILED )); then
      local url; url="$(printf '%s' "$out" | jq -r '.html_url // empty' 2>/dev/null || true)"
      print "✅ Release created for ${curr_tag} titled ${TITLE} (latest=${$MAKE_LATEST_JSON}, previous=${prev_tag})."
      [[ -n "$url" ]] && print "🔗 $url"
    fi
  fi

  rm -f "$section_file" "$payload_file"
  (( STRICT )) && return $FAILED || return 0
}
