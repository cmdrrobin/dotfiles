# Homebrew
export PATH=/opt/homebrew/bin:$PATH

# import Brew shell configurations and environment settings
eval "$(brew shellenv)"

# Antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load ~/dotfiles/zsh/bundles

typeset -U path cdpath fpath manpath

# Vi mode config
#
# Enable zsh's built-in vi mode
bindkey -v

# Bring back some non-vi defaults
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Fuzzy Finder
eval "$(fzf --zsh)"

local fzf_default_opts=(
  '--preview-window right:50%:noborder:hidden'
  '--color=fg:#908caa,bg:#232136,hl:#ea9a97'
  '--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97'
  '--color=border:#44415a,header:#3e8fb0,gutter:#232136'
  '--color=spinner:#f6c177,info:#9ccfd8'
  '--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa'
  '--multi'
  '--bind "alt-p:toggle-preview"'
)

export FZF_DEFAULT_OPTS="${fzf_default_opts[*]}"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"

# allow fzf-tab follow default opts
zstyle ':fzf-tab:*' use-fzf-default-opts yes

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

# History
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

# Load and initialise completion system
autoload -Uz compinit
compinit
