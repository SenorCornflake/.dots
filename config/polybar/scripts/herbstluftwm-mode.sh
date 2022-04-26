
# The shebang will be added by nix

herbstclient watch tags.focus.floating

function display() {
	if [[ $1 == "true" ]]; then
		echo $2
	else
		echo $3
	fi
}

display $(herbstclient get_attr tags.focus.floating) $1 $2

herbstclient --idle "attribute_changed" | {
	while read -r line
	do
		floating=$(herbstclient get_attr tags.focus.floating)
		display $floating $1 $2
	done
}
