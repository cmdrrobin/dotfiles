# Show available tmux sessions when opening a terminal

if [ -z $TMUX ]; then
    SESSION=$(tmux list-sessions -F '#{?session_attached,,#{session_name}}' | sed '/^$/d' | fzf -0 --reverse --header jump-to-session --preview 'tmux capture-pane -pt {}')

    if [ ! -z $SESSION ]; then
        tmux attach-session -t $SESSION
    fi
fi

# vim: ft=zsh
