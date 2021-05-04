#
# CUDA
#
if [[ $(uname -n) =~ "^(baracuda|moss|saffron)" ]] || [[ $(uname -n) =~ "^(bread|corn|rice|koala)$" ]]; then
  export CUDA_HOME="/usr/local/cuda"
  export CUDA_PATH="/usr/local/cuda"
  export PATH="/usr/local/bin:$CUDA_HOME/bin:$PATH"
  export LD_LIBRARY_PATH="/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/local/lib64:$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
  export CUDA_DEVICE_ORDER="PCI_BUS_ID"
fi

#
# Shared programs
#
if [[ -e /home/linuxbrew/.linuxbrew ]]; then
  prefix="/home/linuxbrew/.linuxbrew"
  export PATH="$prefix/opt/python@3.9/libexec/bin:$prefix/bin:$PATH"
  export MANPATH="$prefix/share/man:$MANPATH"
  export INFOPATH="$prefix/share/info:$INFOPATH"
fi
if [[ -e /home/linuxbrew/usr ]]; then
  prefix="/home/linuxbrew/usr"
  export PATH="$prefix/bin:$PATH"
  export MANPATH="$prefix/share/man:$MANPATH"
  export INFOPATH="$prefix/share/info:$INFOPATH"
fi
