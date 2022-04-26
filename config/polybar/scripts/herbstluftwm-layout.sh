
# The shebang will be added by nix
herbstclient watch tags.focus.tiling.focused_frame.algorithm

function display() {
	if [[ $1 == "grid" ]]; then
		echo $2
	elif [[ $1 == "max" ]]; then
		echo $3
	elif [[ $1 == "horizontal" ]]; then
		echo $4
	elif [[ $1 == "vertical" ]]; then
		echo $5
	else
		echo "-"
	fi
}

display $(herbstclient get_attr tags.focus.tiling.focused_frame.algorithm) $1 $2 $3 $4

herbstclient --idle "attribute_changed" | {
	while read -r line
	do
		# When I overcomplicated things
		#focused_winid=$(herbstclient get_attr clients.focus.winid 2> /dev/null)
		#frame_layout=$(herbstclient dump | grep "\(clients \\w+:\\w+ [a-zA-Z0-9 ]*\)" -Eo | grep "$focused_winid" | grep "grid\|max\|horizontal\|vertical" -o)

		# The much easier method
		frame_layout=$(herbstclient get_attr tags.focus.tiling.focused_frame.algorithm)
		display $frame_layout $1 $2 $3 $4
	done
}
