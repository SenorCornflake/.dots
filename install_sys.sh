#/bin/bash

sudo pacman -S xorg xorg-xinit bspwm sxhkd git firefox neofetch neovim xclip brightnessctl scrot go dunst polkit-gnome feh python python-pip picom zsh pulseaudio pulseaudio-alsa alsa-utils alsa-lib qt5ct arch-wiki-docs redshift ttf-fira-code ttf-fira-mono ttf-fira-sans powerline-fonts gvfs-mtp


cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ~

rm -rf ~/yay

yay -S polybar rofi-git zsh-fast-syntax-highlighting zsh-you-should-use find-the-command zsh-history-substring-search-git alacritty-git siji-git ttf-material-design-icons-git pulseaudio-ctl spaceship-prompt-git nerd-fonts-fira-code nerd-fonts-fira-mono nerd-fonts-iosevka visual-studio-code-bin

sudo pip install pywal
sudo pip install pynvim

git clone https://github.com/SenorCornflake/dotfiles
python ~/dotfiles/install.py
