# Activate ~/.virtualenvs/<name> when entering a directory called <name>
activate_virtualenv() {
  [[ -n "$VIRTUAL_ENV" ]] && deactivate
  [[ -d "$WORKON_HOME/$1" ]] && source "$WORKON_HOME/$1/bin/activate"
}

_activate_virtualenv_for_pwd() { activate_virtualenv "${PWD:t}"; }

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _activate_virtualenv_for_pwd
_activate_virtualenv_for_pwd
