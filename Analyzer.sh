updateData() {
  echo "$name = $myScore" >> $1
  echo $(date) >> $1
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> $1
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
      else
        players["$playerName"]=$playerScore
      fi
    fi
  done < $1

  echo "Total wins against opponent" | tee -a $2
  for key in "${!players[@]}"; do
    echo "$key: ${players[$key]}" | tee -a $2
  done
  echo $(date) >> $2
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> $2
}