{ config, pkgs, ... }:

{
  imports = [
    ./autorandr.nix
    ./dunst.nix
    ./exa.nix
    ./firefox.nix
    ./git.nix
    ./gtk.nix
    ./herbstluftwm.nix
    ./home-manager.nix
    ./htop.nix
    ./kitty
    ./lf.nix
    ./macchina.nix
    ./neovim.nix
    ./npm.nix
    ./packages.nix
    ./picom.nix
    ./polybar
    ./qt.nix
    ./qtile.nix
    ./rofi.nix
    ./todo-txt.nix
    ./xdg.nix
    ./xinit.nix
    ./zsh.nix
  ];
}
