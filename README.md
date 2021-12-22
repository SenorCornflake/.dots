# Installation ( on already installed nixos system )
Run `./install.sh all|system|home` on a flake ready system.

# Brand new NixOs Installation
## MBR
### Partitioning
`parted /dev/sda -- mklabel msdos`
`parted /dev/sda -- mkpart primary 1MiB -16GiB`
`parted /dev/sda -- mkpart primary linux-swap -16GiB 100%`
### Formatting
`mkfs.ext4 -L nixos /dev/sda1`
`mkswap -L swap /dev/sda2`
### Installation
`mount /dev/disk/by-label/nixos /mnt`
`swapon -L swap`

# Non-declarative steps (things that must be done on a brand new system)
- Change mysql root password to "root" using `mysql_secure_installation`.
- Recreate /srv/http.
- Enable all firefox plugins for the first time.
- You'll have to type your git password at least once after pushing.
- Recreate mysql website databases.
- Create custom thunar action to open neovim in kitty
- Install docsets for zeal
