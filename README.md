These are my configuration files, it's as simple as that

# Screenshots
![A screenshot of my bspwm configuration](https://github.com/SenorCornflake/dotfiles/blob/master/scrot.jpg "Screenshot")

# How to install
Run install.sh, it creates symbolic links from the repo to your config file. **HOWEVER**, THIS WILL OVERWRITE ANY FILE YOU HAVE WITH THE SAME NAME, so backup.

# Extra
I (currentlyy) use the base16 themes which I have installed for neovim, vscode and termite. I also added some Xresources variables for polybar, rofi and dunst for centralized configuration. Now I just go into my Xresources file and include whatever theme I want for the day. Linux is amazing.

For rofi, termite, neovim and dunst I created scripts that changes placeholders to the colors which the xresources file has enabled that runs when bspwm starts or restarts and so far it's been working quite well.
