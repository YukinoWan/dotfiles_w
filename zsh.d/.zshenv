#
# Defines environment variables.
#

#
# LANG
#
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}

#
# PATH
#
# zsh の機能で、path (array) は PATH と自動的に連動する
# -U: 重複したパスを登録しない
# HOME 以下の path は後で設定するので除外
# (N-/): パスが存在しなければ追加しない
typeset -U path
path=(
  /usr/local/{bin,sbin}(N-/)
  /usr/{bin,sbin}(N-/)
  /{bin,sbin}(N-/)
  ${path:#${HOME}/*}(N-/)
)

#
# PATH FOR MAN(MANUAL)
#
typeset -U manpath
manpath=(
  ${HOME}/.local/share/man(N-/)
  ${HOME}/local/share/man(N-/)
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
  ${manpath:#${HOME}/*}(N-/)
)

#
# FPATH
#
typeset -U fpath
fpath=(
  /usr/local/share/zsh/site-functions(N-/)
  /usr/share/zsh/site-functions(N-/)
  ${fpath:#${HOME}/*}(N-/)
)

# PATH (SUDO)
## -x: export SUDO_PATHも一緒に行う。
## -T: SUDO_PATHとsudo_pathを連動する。
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

if [[ $(id -u) -eq 0 ]]; then  # root user
  path=(${sudo_path} ${path})
fi


case "${OSTYPE}" in
linux*|cygwin*)
  ZSHHOME="${HOME}/dotfiles/zsh.d/linux"
  ;;
freebsd*|darwin*)
  ZSHHOME="${HOME}/dotfiles/zsh.d/macos"
  ;;
esac

# load environment specific configurations
source ${ZSHHOME}/.zshenv


#
# kurolab
#
if [ -d /mnt/berry/home ]; then
    source ${HOME}/dotfiles/zsh.d/kurolab/.zshenv
fi

path=(
  ${HOME}/.local/bin(N-/)
  ${HOME}/local/bin(N-/)
  ${HOME}/usr/bin(N-/)
  ${path}
)
manpath=(
  ${HOME}/.local/share/man(N-/)
  ${HOME}/local/share/man(N-/)
  ${HOME}/usr/share/man(N-/)
  ${manpath}
)
fpath=(
  ${HOME}/.local/share/zsh/site-functions(N-/)
  ${HOME}/local/share/zsh/site-functions(N-/)
  ${HOME}/usr/share/zsh/site-functions(N-/)
  ${fpath}
)
