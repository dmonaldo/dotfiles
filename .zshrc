# Interactive zsh settings. PATH and environment live in ~/.zprofile.

# history, shared live between tmux panes
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

setopt AUTO_CD              # type a directory name to cd into it
setopt INTERACTIVE_COMMENTS # allow # comments on the command line
setopt IGNORE_EOF           # Ctrl-D does not close the shell; type exit
bindkey -e                  # emacs-style line editing, same as bash

# completion: arrow-key menu, case-insensitive matching
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# alias
alias vim="nvim"
alias v="nvim ."
alias dcb="docker-compose build"
alias dcr="docker-compose run --rm --service-ports"
alias dcu="docker-compose up"
alias python="python3"
alias pip="pip3"

for file in ~/.zsh.d/*.zsh(N); do source "$file"; done

# suggestions from history as you type (accept with →), and command highlighting.
# syntax highlighting must be sourced last.
[[ -r $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -r $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
