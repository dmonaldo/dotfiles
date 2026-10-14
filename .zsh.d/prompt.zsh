# Prompt: {venv|branch[stashes]} user@host%jobs:~/path$
# The branch is green when clean and red when tracked files are modified.

_prompt_status() {
  local parts=() branch color git_part stashes
  local sep="%B%F{black}|%f%b"

  [[ -n "$VIRTUAL_ENV" ]] && parts+=("%B%F{yellow}${VIRTUAL_ENV:t}%f%b")

  if branch=$(git symbolic-ref --short -q HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); then
    color=green
    [[ -n "$(git ls-files -m 2>/dev/null)" ]] && color=red
    git_part="%F{$color}${branch//\%/%%}%f"
    stashes=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
    ((stashes > 0)) && git_part+="%B%F{black}[%F{magenta}$stashes%F{black}]%f%b"
    parts+=("$git_part")
  fi

  if ((${#parts})); then
    _PROMPT_STATUS="%B%F{black}{%f%b${(pj:$sep:)parts}%B%F{black}}%f%b "
  else
    _PROMPT_STATUS=""
  fi
}

setopt PROMPT_SUBST
autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_status
PROMPT='${_PROMPT_STATUS}%F{cyan}%n%f@%F{blue}%m%f%(1j.%F{yellow}%%%j%f.)%B%F{black}:%f%b%B%F{green}%~%f%b$ '
