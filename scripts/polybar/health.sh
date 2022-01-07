#!/run/current-system/sw/bin/bash
interval=1200
elapsed=0

while true; do
	if [[ $elapsed == $interval ]]; then
		notify-send "Take a break" "Go outside if possible and look at something far away" -a "" -u critical
		elapsed=0
	else
		remaining=$(($interval - $elapsed))

		if [[ $remaining -lt 60 ]]; then
			if [[ $remaining == 1 ]]; then
				echo "$remaining sec" > $DOT_ROOT/scripts/storage/health.txt
			else
				echo "$remaining secs" > $DOT_ROOT/scripts/storage/health.txt
			fi
		elif [[ $remaining -lt 3600 ]]; then
			minutes=$(/run/current-system/sw/bin/printf "%.0f" $(echo "$remaining/60" | /run/current-system/sw/bin/bc -l))
			if [[ $minutes == 1 ]]; then
				echo "$minutes min" > $DOT_ROOT/scripts/storage/health.txt
			else
				echo "$minutes mins" > $DOT_ROOT/scripts/storage/health.txt
			fi
		else
			hours=$(/run/current-system/sw/bin/printf "%.1f" $(echo "$remaining/60/60" | /run/current-system/sw/bin/bc -l))
			if [[ $hours == 1 ]]; then
				echo "$hours hour" > $DOT_ROOT/scripts/storage/health.txt
			else
				echo "$hours hours" > $DOT_ROOT/scripts/storage/health.txt
			fi
		fi
	fi

	~/.nix-profile/bin/polybar-msg hook health 1

	/run/current-system/sw/bin/sleep 1s
	elapsed=$(($elapsed+1))
done
