
file="$XDG_DATA_HOME/dotfiles/nightmode"

if [[ ! -f $file ]]; then
	echo -n "disabled" > $file
fi

function display() {
	if [[ $1 == "enabled" ]]; then
		echo -n "$2"
	else
		echo -n "$3"
	fi
}

display $(cat $file) $1 $2
