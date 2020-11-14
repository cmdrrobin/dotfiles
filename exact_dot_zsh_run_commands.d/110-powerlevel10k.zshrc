#
# Plugin theme powerlevel10k
# https://github.com/romkatv/powerlevel10k#manual

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Validate existance of ~/.p10k.zsh
if [[ -f "$HOME/.p10k.zsh" ]]; then
    source "$HOME/.p10k.zsh"
fi

# vi: filetype=zsh
