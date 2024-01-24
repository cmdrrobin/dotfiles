# Show available tmux sessions when opening a terminal

if [ -z $TMUX ]; then
    # use sesh when exists!
    if [ -x "$(command -v sesh)" ]; then
        sesh choose
    else
        SESSION=$(tmux list-sessions -F '#{?session_attached,,#{session_name}}' | sed '/^$/d' | fzf -0 --reverse --header jump-to-session --preview 'tmux capture-pane -pt {}')

        if [ ! -z $SESSION ]; then
            tmux attach-session -t $SESSION
        fi
    fi
fi

# vim: ft=zsh
