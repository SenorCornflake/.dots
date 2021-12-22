{ config, pkgs, lib, ... }:
let
  phpmyadmin = "/srv/http";
  phpmyadminConfig = ''
    location /phpmyadmin {
        root ${phpmyadmin};
        index index.php index.html index.htm;
        location ~ ^/phpmyadmin/(.+\.php)$ {
            try_files $uri =404;
            root ${phpmyadmin};
            fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include ${pkgs.nginx}/conf/fastcgi_params;
        }

        location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
            root ${phpmyadmin};
        }
    }
  '';
in
  {
    services = {
      nginx = {
        enable = true;
        config = ''
          events {}

          http {
            # The mime type definitions included with nginx are very incomplete, so
            # we use a list of mime types from the mailcap package, which is also
            # used by most other Linux distributions by default.
            include ${pkgs.mailcap}/etc/nginx/mime.types;
            include ${pkgs.nginx}/conf/fastcgi.conf;
            include ${pkgs.nginx}/conf/uwsgi_params;
            default_type application/octet-stream;
            client_max_body_size 1000M;
            server_tokens off;
            allow all;

            server {
              listen 0.0.0.0:80;
              listen [::0]:80;
              server_name knitandthread.dv;
              root /srv/http/knitandthread.dv/public_html;
              index index.php index.html;
              allow all;

              ${phpmyadminConfig}

              location / {
                try_files $uri $uri/ /index.php;
              }

              location ~ [^/]\.php(/|$) {
                allow all;
                try_files $uri =404;
                fastcgi_split_path_info ^(.+?\.php)(/.*)$;
                fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
                fastcgi_index index.php;
                fastcgi_param  SCRIPT_FILENAME   $document_root$fastcgi_script_name;
                include ${pkgs.nginx}/conf/fastcgi_params;
                index index.php index.html;
              }
            }

            server {
              listen 0.0.0.0:80;
              listen [::0]:80;
              server_name arsenal.dv;
              root /srv/http/arsenal.dv/public_html;
              index index.php index.html;
              allow all;

              ${phpmyadminConfig}

              location / {
                try_files $uri $uri/ /index.php;
              }

              location ~ [^/]\.php(/|$) {
                allow all;
                try_files $uri =404;
                fastcgi_split_path_info ^(.+?\.php)(/.*)$;
                fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
                fastcgi_index index.php;
                fastcgi_param  SCRIPT_FILENAME   $document_root$fastcgi_script_name;
                include ${pkgs.nginx}/conf/fastcgi_params;
                index index.php index.html;
              }
            }

          }
        '';
      };

      mysql = {
        enable = true;
        package = pkgs.mariadb;
      };

      phpfpm = {
        pools = {
          mypool = {
            user = config.services.nginx.user;
            group = config.services.nginx.group;
            settings = {
              pm = "dynamic";
              "listen.owner" = config.services.nginx.user;
              "listen.group" = config.services.nginx.group;
              "listen.mode" = "0755";
              "pm.max_children" = 5;
              "pm.start_servers" = 2;
              "pm.min_spare_servers" = 1;
              "pm.max_spare_servers" = 3;
              "pm.max_requests" = 500;
            };
          };
        };
      };

    };

    networking = {
      hosts = {
        "127.0.0.1" = [
          "arsenal.dv"
          "knitandthread.dv"
        ];
      };
      firewall = {
        enable = false;
      };
    };
    # Apache does work, but for some reason phpmyadmin is just loaded as a blank page, so until I figure out what is happening, I'll have to use nginx
    # services = {
    #   httpd = {
    #     enable = true;
    #     adminAddr = "admin@site.com";
    #     enablePHP = true;
    #     phpPackage = pkgs.php;
    #     extraConfig = ''
    #       DirectoryIndex index.html index.php

    #       Alias /phpmyadmin "${phpmyadmin}"
    #        <Directory "${phpmyadmin}">
    #         AllowOverride All
    #         Options FollowSymlinks
    #         Require all granted
    #        </Directory>
    #     '';

    #     phpOptions = ''
    #       engine = On
    #       error_reporting = E_ALL
    #       display_errors = On
    #       display_startup_errors = On
    #       max_execution_time = 600
    #       memory_limit = 128MB
    #       precision = 14
    #       output_buffering = 4096
    #       implicit_flush = Off
    #       safe_mode = Off
    #       max_input_time = 60
    #       upload_max_filesize = 20
    #     '';

    #     virtualHosts = {
    #       "arsenal.dv" = {
    #         documentRoot = "/srv/http/arsenal.dv/public_html";
    #         hostName = "arsenal.dv";
    #         serverAliases = ["arsenal.dv"];
    #       };
    #       "phpymyadmin.dv" = {
    #         documentRoot = "/srv/http/phpmyadmin.dv/public_html";
    #         hostName = "phpmyadmin.dv";
    #         serverAliases = ["phpmyadmin.dv"];
    #       };
    #     };
    #   };

    #   mysql = {
    #     enable = true;
    #     package = pkgs.mariadb;
    #     dataDir = "/var/lib/mysql";
    #   };
    # };
  }

