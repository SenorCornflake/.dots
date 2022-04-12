{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf attrNames;
  inherit (builtins) pathExists readDir mapAttrs;

  cfg = config.modules.networking.servers.apache;

  # TODO: Figure out how to install phpmyadmin declaratively
  phpmyadmin = "/srv/http/phpmyadmin";

  mkVhost = name: {
    documentRoot = "/srv/http/${name}/public_html";
    hostName = name;
    serverAliases = [name];
  };

  virtualHosts = if pathExists /srv/http then mapAttrs
      (n: v: 
        mkVhost n)
      (readDir /srv/http)
    else {};
in
{
  options.modules.networking.servers.apache = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.httpd = {
      enable = true;
      enablePHP = true;
      adminAddr = "admin@email.com";
      mpm = "prefork";
      phpOptions = ''
       engine = On
       error_reporting = E_ALL
       display_errors = On
       display_startup_errors = On
       max_execution_time = 600
       memory_limit = -1
       max_input_time = 60
       upload_max_filesize = 20
      '';

      extraConfig = ''
        DirectoryIndex index.html index.php

        Alias /phpmyadmin "${phpmyadmin}"
         <Directory "${phpmyadmin}">
          AllowOverride All
          Options FollowSymlinks
          Require all granted
         </Directory>
      '';

      virtualHosts = virtualHosts;
    };

    networking.hosts."127.0.0.1" = attrNames virtualHosts;
  };
}
