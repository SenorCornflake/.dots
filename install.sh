#/bin/bash
shopt -s dotglob

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


for f in "$SCRIPT_DIR"/.config/*; do
	echo "~/.config/`basename "$f"`"
done

for f in "$SCRIPT_DIR"/*; do
	file_name=`basename "$f"`
	if [[ "$file_name" != "install.sh" && "$file_name" != ".git" && "$file_name" != ".root" && "$file_name" != ".config" && "$file_name" != ".gitignore" ]]; then
		echo "~/$file_name"
	fi
done

echo
read -p "The previous files will be forcefully deleted if they exist. Continue? [y/n] " -n 1 -r

echo    # move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

for f in "$SCRIPT_DIR"/.config/*; do
	file_name=`basename "$f"`

	echo "rm -rf ~/.config/$file_name"
	rm -rf ~/.config/"$file_name"

	echo "ln -s $f ~/.config/$file_name"
	ln -s $f ~/.config/"$file_name"
done

for f in "$SCRIPT_DIR"/*; do
	file_name=`basename "$f"`

	if [[ "$file_name" != "install.sh" && "$file_name" != ".git" && "$file_name" != ".root" && "$file_name" != ".config" && "$file_name" != ".gitignore" ]]; then
		echo "rm -rf ~/$file_name"
		rm -rf ~/"$file_name"

		echo "ln -s $f ~/$file_name"
		ln -s $f ~/"$file_name"
	fi
done

shopt -u dotglob
