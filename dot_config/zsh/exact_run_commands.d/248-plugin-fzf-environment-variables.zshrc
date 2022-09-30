#
## Plugin :: fzf :: Environment variables

# Variable modification :: FZF_DEFAULT_OPTS
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
  --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Variable modification :: FZF_CTRL_T_COMMAND
export FZF_CTRL_T_COMMAND='fd --exclude '.git' --hidden --no-ignore-vcs --type f | izer iconize -f=nerd -c'
# Variable modification :: FZF_CTRL_T_OPTS
# shellcheck disable=SC2155
export FZF_CTRL_T_OPTS="--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1 --bind '$(fzf_ctrl_t_key_bindings)' --preview-window down:40%:noborder --preview 'izer deiconize {} | xargs bat --line-range :150 --style=changes,numbers,snip --wrap=never 2> /dev/null'"

# Variable modification :: FZF_CTRL_R_OPTS
export FZF_CTRL_R_OPTS='--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1'

# Variable modification :: FZF_ALT_C_COMMAND
export FZF_ALT_C_COMMAND='fd --exclude '.git' --hidden --no-ignore-vcs --type d'
# Variable modification :: FZF_ALT_C_OPTS
export FZF_ALT_C_OPTS="--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1 --preview-window=down:40%:noborder --preview 'exa --color=always --color-scale --group --git --icons --long --tree {} | head -150'"

# Variable modification :: FZF_COMPLETION_TRIGGER
export FZF_COMPLETION_TRIGGER=',,'
# Variable modification :: FZF_COMPLETION_OPTS
export FZF_COMPLETION_OPTS='--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1'

# vi: filetype=zsh
