export PATH=/opt/homebrew/bin:$PATH

# import Brew shell configurations and environment settings
eval "$(brew shellenv)"

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

typeset -U path cdpath fpath manpath

plug "zsh-users/zsh-autosuggestions"
plug "Aloxaf/fzf-tab"
plug "zdharma-continuum/fast-syntax-highlighting"

# History
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# Fuzzy find
if [[ $options[zle] = on ]]; then
  eval "$(fzf --zsh)"

  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --multi"
  export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"

  # Advanced customization of fzf options via _fzf_comprun function
  # - The first argument to the function is the name of the command.
  # - You should make sure to pass the rest of the arguments to fzf.
  _fzf_comprun() {
    local command=$1
    shift
  
    case "$command" in
      cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
      export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
      ssh)          fzf --preview 'dig {}'                   "$@" ;;
      *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
    esac
  }
fi

# Starship prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# 1Password
source /Users/robin/.config/op/plugins.sh

# Aliases
alias -- s='sesh connect $(sesh list | fzf)'
alias -- vi=nvim
alias -- vim=nvim

# Sesh
function sesh-sessions() {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# Variables
export LANG="en_US.UTF-8";
export LC_CTYPE="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";
export XDG_CONFIG_HOME="$HOME/.config";
export XDG_DATA_HOME="$HOME/.local/share";
export XDG_CACHE_HOME="$HOME/.cache";
export EDITOR="nvim";
export PAGER="less -FirSwX";
export CLICOLOR=1;
export SSH_AUTH_SOCK="/Users/robin/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
#
# Load and initialise completion system
autoload -Uz compinit
compinit
