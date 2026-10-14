# Login shell environment: PATH and exported variables.
# Interactive settings (aliases, prompt, completion) live in ~/.zshrc.

eval "$(/opt/homebrew/bin/brew shellenv)"

typeset -U path # drop duplicate PATH entries
path=(
  $HOME/.local/bin
  $HOME/.opencode/bin
  $HOME/Library/pnpm
  /opt/homebrew/opt/postgresql@17/bin
  /opt/homebrew/opt/libpq/bin
  $path
)

export PNPM_HOME="$HOME/Library/pnpm"
export NVM_DIR="$HOME/.nvm"
export WORKON_HOME="$HOME/.virtualenvs"
export VIRTUAL_ENV_DISABLE_PROMPT=1 # the prompt shows the active virtualenv itself

# Secrets, untracked by yadm (see ~/.bash.env.example)
[[ -r ~/.bash.env ]] && source ~/.bash.env
