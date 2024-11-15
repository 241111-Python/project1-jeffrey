#!/usr/bin/bash

updateData() {
  echo "$name = $myScore" >> "$(realpath "$1")"
  echo "Opponent = $oppScore" >> "$(realpath "$1")"
  echo $(date) >> "$(realpath "$1")"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> "$(realpath "$1")"
}

updateScoreboard() {
  declare -A players
  while IFS= read -r line; do
    index=$(expr index "$line" "=")
    if [ "$index" -gt 0 ]; then
      playerName=${line:0:$((index-2))}
      playerScore=${line:$((index))}

      if [[ -v players["$playerName"] ]]; then
        players["$playerName"]=$(( players["$playerName"] + $playerScore ))
      elif [[ $playerName != "Opponent" ]]; then
        players["$playerName"]=$playerScore
      fi
    fi
  done < "$(realpath "$1")"

  echo "Total wins against opponent" | tee -a "$(realpath "$2")"
  for key in "${!players[@]}"; do
    echo "$key: ${players[$key]}" | tee -a "$(realpath "$2")"
  done
  echo $(date) >> "$(realpath "$2")"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> "$(realpath "$2")"
}

if [ "${1:0:5}" == "/mnt/" ]; then
  updateScoreboard "${1:-7}" "${2:-14}"
fi
