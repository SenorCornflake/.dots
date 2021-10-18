{ config, pkgs, lib, ... }:

{
  boot.loader.grub = {
    enable = true;
    version = 2;
    devices = ["/dev/sda"];
    #extraEntries = ''
    #  menuentry "Arch" {
    #    search --no-floppy --set=root --fs-uuid 2e3c8295-aa84-4754-924f-0e02b317d842

    #    echo "Loading kernel..."
    #    linux /boot/vmlinuz-linux root=UUID=2e3c8295-aa84-4754-924f-0e02b317d842 rw loglevel=3
    #    echo "Loading initial ram disk..."
    #    initrd /boot/initramfs-linux.img
    #  }
    #'';
    splashImage = /home/a/Pictures/wallpapers/dark-market-in-night-pixels.jpg;
    useOSProber = true;
  };
}
