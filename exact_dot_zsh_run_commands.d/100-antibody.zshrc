#
# Shell plugin manager: Antibody
# https://getantibody.github.io/

# Dynamic load
source <(antibody init)

# Bundle plugin(s)
antibody bundle < ~/.zsh_plugins.txt

# vi: filetype=zsh
