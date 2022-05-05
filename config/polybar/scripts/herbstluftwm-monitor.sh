
# The shebang will be added by nix

herbstclient watch monitors.focus.index

echo $(herbstclient get_attr monitors.focus.index)

herbstclient --idle "attribute_changed" | {
	while read -r line
	do
		if [[ $(echo "$line" | grep "monitors.focus.index") ]]; then
			index=$(echo "$line" | awk '{print $4}')
			#monitor=$(xrandr --listmonitors | grep "$index:" | awk '{print $4}')
			echo "$index"
		fi
	done
}
