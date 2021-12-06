{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      myprofile = {
        settings = {
          "general.autoScroll" = true;
          "general.smoothScroll" = true;
        };
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
    ];
  };
}


/* \e[34m          ::::.    \e[36m':::::     ::::'
\e[34m          ':::::    \e[36m':::::.  ::::'
\e[34m            :::::     \e[36m'::::.:::::
\e[34m      .......:::::..... \e[36m::::::::
\e[34m     ::::::::::::::::::. \e[36m::::::    <blue>::::.
    ::::::::::::::::::::: \e[36m:::::.  \e[34m.::::'
\e[36m           .....           ::::' \e[34m:::::'
\e[36m          :::::            '::' \e[34m:::::'
\e[36m ........:::::               ' \e[34m:::::::::::.
\e[36m:::::::::::::                 \e[34m:::::::::::::
\e[36m ::::::::::: \e[34m..              <blue>:::::
\e[36m     .::::: \e[34m.:::            <blue>:::::
\e[36m    .:::::  \e[34m:::::          <blue>'''''    <cyan>.....
    :::::   \e[34m':::::.  \e[36m......:::::::::::::'
     :::     \e[34m::::::. \e[36m':::::::::::::::::'
\e[34m            .:::::::: \e[36m'::::::::::
\e[34m           .::::''::::.     \e[36m'::::.
\e[34m          .::::'   ::::.     \e[36m'::::.
\e[34m         .::::      ::::      \e[36m'::::.
<reset> */
