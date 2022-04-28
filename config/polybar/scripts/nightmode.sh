
file="$XDG_DATA_HOME/dotfiles/nightmode"

if [[ ! -f $file ]]; then
	echo -n "disabled" > $file
fi

function display() {
	if [[ $1 == "enabled" ]]; then
		echo "$2"
	else
		echo "$3"
	fi
}

display $(cat $file) $1 $2

while true
do
	sleep 3s
	display $(cat $file) $1 $2
done
