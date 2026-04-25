#!/usr/bin/env bash
current_session=$(tmux display-message -p '#{session_name}')
all_sessions=$(tmux list-sessions -F '#{session_name}')

mapfile -t sessions <<< "$all_sessions"
total=${#sessions[@]}

if (( total <= 1 )); then
    tmux kill-session -t "$current_session"
    exit 0
fi

found=-1
for i in "${!sessions[@]}"; do
    if [[ "${sessions[$i]}" == "$current_session" ]]; then
        found=$i
        break
    fi
done

next_index=$(( (found + 1) % total ))
next_session="${sessions[$next_index]}"

tmux switch-client -t "$next_session"
tmux kill-session -t "$current_session"
