# Export tty
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
# vim: ft=zsh
