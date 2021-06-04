# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{bash_prompt,aliases}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Some Less Colors
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Less man wrapper
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

if [ -f /usr/bin/subl ] || [ -f /usr/local/bin/subl ]
then
    # Use subl as editor
    export EDITOR='subl -w'
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
## complete -W "NSGlobalDomain" defaults

# Homebrew config
if command -v brew >/dev/null 2>&1; then
	# For homebrew, prioritizes hombrew binaries
	export PATH="/usr/local/bin:$PATH"
fi

if [ -f ~/.rbenv/bin/rbenv ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

if [ -d /Library/Frameworks/Python.framework/Versions/3.6/bin ]; then
	# Setting PATH for Python 3.6
	# The original version is saved in .bash_profile.pysave
	export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
fi

# Perl6 Mac
if [ -d /Applications/Rakudo/ ]; then
    export PATH=$PATH:/Applications/Rakudo/bin:/Applications/Rakudo/share/perl6/site/bin
fi

# DNS Helpers
whodns () {
    basedomain=`echo $1 | rev | cut -d'.' -f1,2 | rev`
    dnsdomain=$(dig +short NS $basedomain | head -1 | rev | cut -d"." -f2,3 | rev)
    whois $dnsdomain | grep "Registrant Organization: " | cut -d":" -f2 | sed -e 's/^[[:space:]]*//'
}

whoregistrar () {
    basedomain=`echo $1 | rev | cut -d'.' -f1-2 | rev`
    whois $basedomain | grep "Registrar: " | head -1 | cut -d":" -f2 | sed -e 's/^[[:space:]]*//'
}

# Case insensitive tab completion
bind 'set completion-ignore-case on'

