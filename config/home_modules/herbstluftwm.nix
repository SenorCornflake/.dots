{ config, pkgs, ... }:

{
  home.file."autostart" = {
    text = builtins.readFile ../config/herbstluftwm/autostart;
    target = ".config/herbstluftwm/autostart";
    executable = true;
  };
  home.file."rules" = {
    text = builtins.readFile ../config/herbstluftwm/rules;
    target = ".config/herbstluftwm/rules";
    executable = true;
  };
  home.file."keybindings" = {
    text = builtins.readFile ../config/herbstluftwm/keybindings;
    target = ".config/herbstluftwm/keybindings";
    executable = true;
  };
  home.file."settings" = {
    text = builtins.readFile ../config/herbstluftwm/settings;
    target = ".config/herbstluftwm/settings";
    executable = true;
  };

  home.file."polkit" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      pidof ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 || ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    '';
    target = ".config/herbstluftwm/polkit";
    executable = true;
  };

  home.file."wallpaper" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      feh --no-fehbg --bg-fill "$(cat $DOT_ROOT/scripts/storage/wallpaper.txt)"
    '';
    target = ".config/herbstluftwm/wallpaper";
    executable = true;
  };
}
