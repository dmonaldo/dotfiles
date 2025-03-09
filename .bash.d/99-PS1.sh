_set_prompt () {
    reset="\[$(tput sgr0)\]"
    dark_gray="\[$(tput setaf 0)\]"
    bold_dark_gray="\[$(tput setaf bold)$(tput setaf 0)\]"
    red="\[$(tput setaf 1)\]"
    bold_red="\[$(tput setaf bold)$(tput setaf 1)\]"
    green="\[$(tput setaf 2)\]"
    bold_green="\[$(tput setaf bold)$(tput setaf 2)\]"
    yellow="\[$(tput setaf 3)\]"
    bold_yellow="\[$(tput setaf bold)$(tput setaf 3)\]"
    blue="\[$(tput setaf 4)\]"
    bold_blue="\[$(tput setaf bold)$(tput setaf 4)\]"
    purple="\[$(tput setaf 5)\]"
    bold_purple="\[$(tput setaf bold)$(tput setaf 5)\]"
    turquoise="\[$(tput setaf 6)\]"
    bold_turquoise="\[$(tput setaf bold)$(tput setaf 6)\]"
    light_gray="\[$(tput setaf 7)\]"
    bold_light_gray="\[$(tput setaf bold)$(tput setaf 7)\]"

    function join_by {
      local d=${1-} f=${2-}
      if shift 2; then
        printf %s "$f" "${@/#/$d}"
      fi
    }

    HOSTPS1="$blue\h$reset"
    JOBSC=$(jobs | wc -l | awk '{print $1}')
    if [ "$JOBSC" != "0" ]; then
        HOSTPS1="$HOSTPS1$yellow%$JOBSC$reset"
    fi

    PS1="$turquoise\u$reset@$HOSTPS1$bold_dark_gray:$reset$bold_green\w$reset\$ "

    if [ -n "$VIRTUAL_ENV" ]; then
#        VENVPS1=$(printf "$bold_yellow%s$reset" $(basename $VIRTUAL_ENV))
		VENVPS1="$bold_yellow$(basename $VIRTUAL_ENV)$reset"
    else
        unset VENVPS1
    fi

    GITBR=$(git branch 2>/dev/null)
    if [ -n "$GITBR" ]; then
        if [ -z "$(git ls-files -m)" ]; then
            GITCOLOR=$green
        else
            GITCOLOR=$red
        fi
        GITPS1="$GITCOLOR\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$reset"

        STASH=$(git stash list | wc -l)
        if [ "$STASH" != "0" ]; then
            GITPS1="$GITPS1$(printf "$bold_dark_gray[$reset$bold_purple%s$reset$bold_dark_gray]$reset" $STASH)"
        fi
    else
        unset GITPS1
    fi

    if [[ -n "$GITPS1" || -n "$VENVPS1" ]]; then
        STATUS=$(join_by "$bold_dark_gray|$reset" "$VENVPS1" "$GITPS1")
        PS1="$bold_dark_gray{$reset$STATUS$bold_dark_gray}$reset $PS1"
    fi
}
PROMPT_COMMAND=_set_prompt
