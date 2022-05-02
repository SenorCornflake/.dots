{ config, lib, pkgs, ... }:

let
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) types;

  cfg = config.modules.misc.qt;
in
{
  options.modules.misc.qt = {
    theme = mkOpt types.str "adwaita-dark";
  };

  config = {
    home-manager.users."${config.userName}" = {
      qt = {
        enable = true;
      };
    };
  };
}
