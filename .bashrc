export BASH_SILENCE_DEPRECATION_WARNING=1

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt:$PATH"

# node via fnm (see ~/.zprofile)
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd --log-level=error --version-file-strategy=recursive --shell bash 2>/dev/null)"

export PATH=/usr/local/share/python:$PATH
export PATH=/opt/homebrew/opt/libpq/bin:$PATH

# configuration for virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
# source $(which virtualenvwrapper.sh)
# export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3
# export VIRTUALENVWRAPPER_VIRTUALENV=/opt/homebrew/bin/virtualenv
# source /opt/homebrew/bin/virtualenvwrapper.sh

# aws cli
export PATH=~/.local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# alias
alias vim="nvim"
alias v="nvim ."
alias python="python3"
alias pip="pip3"

# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path --no-rehash)"

for file in ~/.bash.d/*; do source $file; done

source ~/.bash.env

export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
