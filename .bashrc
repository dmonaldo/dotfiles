export BASH_SILENCE_DEPRECATION_WARNING=1

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/Homebrew/opt/nvm/nvm.sh" ] && \. "/usr/local/Homebrew/opt/nvm/nvm.sh"
[ -s "/usr/local/Homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/Homebrew/opt/nvm/etc/bash_completion.d/nvm"

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
alias dcb="docker-compose build"
alias dcr="docker-compose run --rm --service-ports"
alias dcu="docker-compose up"
alias python="python3"
alias pip="pip3"

# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path --no-rehash)"

for file in ~/.bash.d/*; do source $file; done

source ~/.bash.env
