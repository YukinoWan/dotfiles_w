#
# Executes commands at the start of an interactive session.
#

# Aliases
alias j='jumanpp'
alias jk='jumanpp | knp'
alias -g J='| jumanpp'
alias -g K='| knp'
alias -g Kt='| knp -tab'
alias -g JK='| jumanpp | knp'
alias -g JKt='| jumanpp | knp -tab'

# Custom settings that use packages installed by linuxbrew.

#
# https://github.com/sharkdp/bat
# bat is a modern alternative to cat. If you want to use bat instead of cat, uncomment the following lines.
#
# if [ -x "$(command -v bat)" ]; then
#   alias cat='bat'
# fi

#
# https://github.com/ogham/exa
# exa is a modern alternative to ls. If you want to use exa instead of ls, uncomment the following lines.
#
# if [ -x "$(command -v exa)" ]; then
#   alias l='exa --color=auto'
#   alias la='exa -a --color=auto'
#   alias ll='exa -la --color=auto'
#   alias lt='exa -ls old --color=auto'
#   alias lat='exa -las old --color=auto'
#   alias ls='exa --color=auto'
# fi

#
# https://github.com/junegunn/fzf
# fzf is a command-line fuzzy finder.
#
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

__fsel() {
  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}

fzf-cd-widget() {
  local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-20%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="cd ${(q)dir}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}

fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

# Uncomment the following lines to enable functions using fzf.
# if [ -x "$(command -v fzf)" ]; then
#   # ctrl-t: Paste the selected file path(s) into the command line.
#   zle -N fzf-file-widget
#   bindkey '^T' fzf-file-widget
#   # alt-c: cd into the selected directory.
#   zle -N fzf-cd-widget
#   bindkey '\ec' fzf-cd-widget
#   # ctrl-r: Paste the selected command from history into the command line.
#   zle -N fzf-history-widget
#   bindkey '^R' fzf-history-widget
# fi
