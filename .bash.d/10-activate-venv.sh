# Function to activate virtual environment based on the current directory
function activate_virtualenv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
  fi
  if [ -d "$HOME/.virtualenvs/$1" ]; then
    source "$HOME/.virtualenvs/$1/bin/activate"
  fi
}

# Hook into the cd command
function cd() {
  builtin cd "$@" || return
  activate_virtualenv "$(basename "$PWD")"
}

# Activate virtualenv if starting in a project directory
activate_virtualenv "$(basename "$PWD")"
