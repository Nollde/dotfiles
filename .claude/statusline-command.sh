#!/bin/sh
# Parse all JSON fields in one jq pass; @sh shell-quotes each value safely.
input=$(cat)
eval "$(printf '%s' "$input" | jq -r '
  @sh "model=\(.model.display_name // "Unknown Model")",
  @sh "effort=\(.effort.level // "")",
  @sh "used=\(.context_window.used_percentage // "")",
  @sh "total_cost=\(.cost.total_cost_usd // "")",
  @sh "rl_5h_pct=\(.rate_limits.five_hour.used_percentage // "")",
  @sh "rl_5h_reset=\(.rate_limits.five_hour.resets_at // "")",
  @sh "rl_7d_pct=\(.rate_limits.seven_day.used_percentage // "")",
  @sh "rl_7d_reset=\(.rate_limits.seven_day.resets_at // "")"
')"

# Round percentages to integers (empty stays empty).
[ -n "$rl_5h_pct" ] && rl_5h_pct=$(awk -v v="$rl_5h_pct" 'BEGIN { printf "%.0f", v }')
[ -n "$rl_7d_pct" ] && rl_7d_pct=$(awk -v v="$rl_7d_pct" 'BEGIN { printf "%.0f", v }')

if [ -n "$used" ]; then
  usage_str="$(awk -v v="$used" 'BEGIN { printf "%.0f", v }')%"
else
  usage_str="0%"
fi

GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
RESET='\033[0m'

if [ -n "$total_cost" ]; then
  # awk -v avoids injecting JSON data into the awk program text.
  cost_display=$(awk -v v="$total_cost" 'BEGIN { printf "%.2f", v }')
  block_str="\$${cost_display}"
else
  block_str="\$0.00"
fi

make_bar() {
  pct="$1"
  width=10
  filled=$(( pct * width / 100 ))
  empty=$(( width - filled ))
  bar=""
  i=0
  while [ $i -lt $filled ]; do bar="${bar}█"; i=$(( i + 1 )); done
  while [ $i -lt $width ];  do bar="${bar}░"; i=$(( i + 1 )); done
  printf '%s' "$bar"
}

format_rl() {
  pct="$1"
  reset_ts="$2"
  label="$3"
  [ -z "$pct" ] && return
  if [ "$pct" -ge 90 ]; then color="$RED"
  elif [ "$pct" -ge 70 ]; then color="$YELLOW"
  else color="$GREEN"
  fi
  reset_time=$(date -r "$reset_ts" "+%-I:%M%p" 2>/dev/null || date -d "@$reset_ts" "+%-I:%M%p" 2>/dev/null)
  bar=$(make_bar "$pct")
  # Data goes through %s/%b args, never the format string — no format-spec injection.
  printf '%b%s %s %s%% resets %s%b' "$color" "$label" "$bar" "$pct" "$reset_time" "$RESET"
}

rate_limit_str=$(format_rl "$rl_5h_pct" "$rl_5h_reset" "5h")
# rate_limit_str="${rate_limit_str}$(format_rl "$rl_7d_pct" "$rl_7d_reset" "7d")"

if [ -n "$effort" ]; then
  printf '🤖 %s | 💪 %s | 🧠 %s | 💰 %s | ⏱️ %b' \
    "$model" "$effort" "$usage_str" "$block_str" "$rate_limit_str"
else
  printf '🤖 %s | 🧠 %s | 💰 %s | ⏱️ %b' \
    "$model" "$usage_str" "$block_str" "$rate_limit_str"
fi
