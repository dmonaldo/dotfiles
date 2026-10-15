# Login shell environment: PATH and exported variables.
# Interactive settings (aliases, prompt, completion) live in ~/.zshrc.

eval "$(/opt/homebrew/bin/brew shellenv)"

typeset -U path # drop duplicate PATH entries
path=(
  $HOME/.local/bin
  $HOME/.opencode/bin
  $HOME/Library/pnpm
  $HOME/.cargo/bin
  /opt/homebrew/opt/rustup/bin
  /opt/homebrew/opt/python@3.14/libexec/bin # python3/pip3 (python@3.15 is brew's default now)
  /opt/homebrew/opt/postgresql@17/bin
  /opt/homebrew/opt/libpq/bin
  $path
)

# Node via fnm: switches to the version in .nvmrc/.node-version on cd,
# otherwise the default version (set with `fnm default <version>`)
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd --log-level=error --version-file-strategy=recursive --shell zsh 2>/dev/null)"

export PNPM_HOME="$HOME/Library/pnpm"
export WORKON_HOME="$HOME/.virtualenvs"
export VIRTUAL_ENV_DISABLE_PROMPT=1 # the prompt shows the active virtualenv itself

# Secrets, untracked by yadm (see ~/.bash.env.example)
[[ -r ~/.bash.env ]] && source ~/.bash.env
