#!/usr/bin/env bash

set -xu

DOTDIR=$(
  cd "$(dirname "$0")"
  pwd
)
cd "$DOTDIR"

#
# zsh
#
ZDOTDIR=${DOTDIR%/}/zsh.d
for f in ${ZDOTDIR%/}/.??*; do
  ln -snfv "$f" "$HOME"
done

#
# tmux
#
TMUXDORDIR=${DOTDIR%/}/tmux.d
for f in ${TMUXDORDIR%/}/.??*; do
  ln -snfv "$f" "$HOME"
done
