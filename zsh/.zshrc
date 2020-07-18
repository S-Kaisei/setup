# Created by newuser for 5.8
# brew install zsh
# brew install zsh-completion
# open /etc/shells and add /usr/local/bin/zsh
# chsh -s /usr/local/bin/zsh

fpath=(path/to/zsh-completions/src $fpath)

autoload -U colors
colors

autoload -U compinit
compinit

autoload -U vcs_info
vcs_info

if [ -r ~/.zsh_alias ]
then
   source ~/.zsh_alias
fi

function chpwd() { l }

function open_typora() {
    if [ $# = 0 ]; then
	open -a typora
    elif [ $# = 1 ]; then
	\touch $1
	open -a typora $1
    else
	echo "invalid argument!"
    fi
}

function precmd_vcs_info() { vcs_info }

precmd_functions+=( precmd_vcs_info )

export LSCOLORS=Gxfxcxdxbxegedabagacad
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=100

setopt AUTO_PUSHD
setopt auto_param_keys
setopt CORRECT
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_no_store
setopt prompt_subst

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:' ignore-parents parent pwd
zstyle ':completion:*descriptions' format '%BCompleting%b %U%d%u'
zstyle ':completion:*' list-colors "${LSCOLORS}"
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':vcs_info:git:*' formats '[%b]'

PROMPT="%{${fg[red]}%} %B%~%b %{${fg[green]}%}%B\$vcs_info_msg_0_%b
 %{${fg[cyan]}%}%Bkaisei $ %b"
