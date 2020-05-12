

for i in ~/dotfiles/.config/*; do
    rm -rf ~/.config/`basename $i`
    ln -s $i ~/.config/`basename $i`
done

