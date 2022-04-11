{ pkgs, ... }:

{
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    polkit = {
      enable = true;
    };
  };

  systemd.user.services.polkit_gui = {
    description = "A graphical interface for polkit";
    serviceConfig = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &";
    };
  };
}
