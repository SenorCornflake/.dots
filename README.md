These are my configuration files, it's as simple as that

# How to install
Simply install a package called "stow", clone this repo and execute the command `stow * -t ~` inside of it
This should create symlinks in your `.config` folder which points to corresponding folders in the dotfiles repo.

**NOTE:** Once you've cloned this repo, you can move it anywhere you want, but after executing the `stow` command inside of it
if you move it you'll mave to execute `stow * -t ~` inside of it again to update it's location.

## NOTES
I learned about stow from Wolfgang on this video `stow`, [https://www.youtube.com/watch?v=MJBVA4LeJKA](https://www.youtube.com/watch?v=MJBVA4LeJKA)
