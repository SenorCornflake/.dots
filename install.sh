

for i in ~/dotfiles/.config/*; do
    rm -rf ~/.config/`basename $i`
    ln -s $i ~/.config/`basename $i`
done

for i in $(find -maxdepth 1 -type f | sed "/README.md/d" | sed "/install.sh/d" | sed "/scrot*/d"); do
    rm -rf ~/`basename $i`
    ln -s ~/dotfiles/`basename $i` ~/`basename $i`
done
