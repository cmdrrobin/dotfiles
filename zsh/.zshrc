# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab"
plug "zdharma-continuum/fast-syntax-highlighting"

# load local configs
export ZSH="$HOME/.config/zsh"
plug "$HOME/.config/zsh/run_commands.d/*"

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

eval "$(starship init zsh)"

# Load and initialise completion system
autoload -Uz compinit
compinit
