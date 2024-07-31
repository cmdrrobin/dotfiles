alias zf="fd . -t file --exclude '.git' $HOME/zettelkasten/ | fzf --preview 'bat {}'| xargs -o nvim"
