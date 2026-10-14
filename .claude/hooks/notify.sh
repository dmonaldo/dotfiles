#!/bin/bash
# Claude Code notification hook: macOS banner + terminal bell + tmux window status.
# Reads the hook's JSON payload on stdin and tailors the output to the event:
#   UserPromptSubmit, PostToolUse -> ⏳ in the tmux window list (no banner)
#   PermissionRequest             -> ✋ + "Needs approval" banner naming the tool
#   Stop                          -> ✅ + "Claude finished" banner with the last reply
#   SessionEnd                    -> clears the tmux window status
# Clicking a banner focuses Ghostty and jumps to the session's tmux pane.

input=$(cat)
field() { jq -r "$1 // empty" <<<"$input" 2>/dev/null; }

event=$(field '.hook_event_name')

# Show Claude's state next to the window name (rendered by window-status-format).
set_window_status() {
  [ -n "$TMUX_PANE" ] || return
  if [ -n "$1" ]; then
    tmux set -w -t "$TMUX_PANE" @claude "$1" 2>/dev/null
  else
    tmux set -wu -t "$TMUX_PANE" @claude 2>/dev/null
  fi
}

case "$event" in
UserPromptSubmit | PostToolUse)
  set_window_status "⏳"
  exit 0
  ;;
SessionEnd)
  set_window_status ""
  exit 0
  ;;
PermissionRequest) set_window_status "✋" ;;
*) set_window_status "✅" ;;
esac

cwd=$(field '.cwd')
cwd="${cwd:-$PWD}"
session_id=$(field '.session_id')

project="${cwd##*/}"
branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
subtitle="$project${branch:+ · $branch}"

# Flatten markdown into one plain line that fits in a banner.
plain_text() {
  sed -E 's/^[[:space:]]*[-*][[:space:]]+/• /' |
    tr '\n' ' ' |
    sed -E "s/\[([^]]*)\]\([^)]*\)/\1/g; s/[*\`#>|]+//g; s|$HOME|~|g; s/[[:space:]]+/ /g; s/^ //; s/ $//" |
    cut -c1-200
}

case "$event" in
PermissionRequest)
  title="✋ Needs approval"
  sound="Funk"
  message=$(jq -r '
    .tool_name as $tool | .tool_input as $in |
    (if ($tool | startswith("mcp__"))
       then ($tool | split("__") | "\(.[1] | sub("^claude_ai_"; "")) · \(.[2])")
       else $tool end) as $label |
    ($in.description // $in.command // $in.file_path // $in.url // $in.pattern // $in.query // "") as $detail |
    if $detail == "" then $label else "\($label): \($detail)" end
  ' <<<"$input" 2>/dev/null | plain_text)
  ;;
*)
  title="✅ Claude finished"
  sound="Glass"
  message=$(field '.last_assistant_message' | plain_text)
  ;;
esac
message="${message:-Waiting for you}"

if command -v terminal-notifier >/dev/null 2>&1; then
  click_args=(-activate com.mitchellh.ghostty)
  if [ -n "$TMUX_PANE" ]; then
    tmux_bin=$(command -v tmux)
    click_args+=(-execute "$tmux_bin switch-client -t '$TMUX_PANE' \\; select-window -t '$TMUX_PANE' \\; select-pane -t '$TMUX_PANE'")
  fi
  # One banner per session: a newer event replaces the older one.
  terminal-notifier -title "$title" -subtitle "$subtitle" -message "$message" \
    -group "claude-code-${session_id:-$project}" "${click_args[@]}" >/dev/null 2>&1
fi

# Play the sound directly; Notification Center sounds get muted by Focus modes.
afplay "/System/Library/Sounds/$sound.aiff" >/dev/null 2>&1 &

# Hooks run without a controlling terminal, so /dev/tty is unavailable.
# Ring the bell on the tmux pane's tty instead; tmux forwards it to Ghostty.
if [ -n "$TMUX_PANE" ]; then
  pane_tty=$(tmux display -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
  [ -w "$pane_tty" ] && printf '\a' >"$pane_tty"
fi

exit 0
