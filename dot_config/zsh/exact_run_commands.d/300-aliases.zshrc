#
## Aliases

zsh_aliases_if=($ZDOTDIR/aliases.d/*.zshrc) 2> /dev/null

if [ ${#zsh_aliases_if[@]} -gt 0 ]; then
    # Action :: Loop over Z shell environment variable include files
    foreach zsh_alias (`echo ${zsh_aliases_if[@]} | sort`)
        source "$zsh_alias"
    end
fi

# vi: filetype=zsh
