{ config, pkgs, ... }:

{
  security = {
    # This doesn't seem to do anything
    polkit = {
      enable = true;
    };
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
