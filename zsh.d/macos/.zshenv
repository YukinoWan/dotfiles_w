#
# Defines macOS-specific environment variables.
#

## ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
unsetopt GLOBAL_RCS

path=(
  /opt/X11/bin(N-/)  # X11
  ${path}
)
