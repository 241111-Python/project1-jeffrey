#!/usr/bin/bash
source Analyzer.sh # importing file

myScore=0
oppScore=0
oppChoice=""

echo "What is your name?"
read -r name
echo "~~~~~~~~~~~~~~~~ Welcome $name ~~~~~~~~~~~~~~~~~"

while [[ ! -v choice || $choice != "end" ]]; do
	randomNum=$(( ($RANDOM % 3) + 1 ))	
	echo "Choose rock, paper, or scissors. To stop playing, type end"
	read -r choice
	choice=${choice,,}

	case $randomNum in
		1)
			oppChoice="rock"
			if [[ $choice == "rock" ]]; then
				echo "You tied!"		
			elif [[ $choice == "paper" ]]; then
				myScore=$(( myScore + 1 ))
				echo "You win!"		
			elif [[ $choice == "scissors" ]]; then
				oppScore=$(( oppScore + 1 ))
				echo "You lose!"		
			elif [[ $choice != "end" ]]; then
				echo "Invalid choice!"
			fi
			;;
		2)
			oppChoice="paper"
			if [[ $choice == "rock" ]]; then
				oppScore=$(( oppScore + 1 ))
				echo "You lose!"		
			elif [[ $choice == "paper" ]]; then
				echo "You tied!"		
			elif [[ $choice == "scissors" ]]; then
				myScore=$(( myScore + 1 ))
				echo "You win!"
			elif [[ $choice != "end" ]]; then
				echo "Invalid choice!"
			fi
			;;

		3)
			oppChoice="scissors"
			if [[ $choice == "rock" ]]; then
				myScore=$(( myScore + 1 ))
				echo "You win!"		
			elif [[ $choice == "paper" ]]; then
				oppScore=$(( oppScore + 1 ))
				echo "You lose!"		
			elif [[ $choice == "scissors" ]]; then
				echo "You tied!"
			elif [[ $choice != "end" ]]; then
				echo "Invalid choice!"
			fi
			;;
		*)
			echo "Game error!"
			;;
	esac

	echo "$name: $myScore"
	echo "Opponent: $oppScore"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
done

FILE="Data.md"
FILE2="Scoreboard.txt"
updateData $FILE
updateScoreboard $FILE $FILE2

echo "Thank you for playing!"
