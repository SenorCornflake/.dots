
{ stdenv, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "phpmyadmin";
  version = "5.1.1";
  src = pkgs.fetchurl {
    url = "https://files.phpmyadmin.net/phpMyAdmin/${version}/phpMyAdmin-${version}-all-languages.tar.gz";
    sha256 = "gmS1euqh+RxthZMxd3xx6A0mCIvvfNzV+UMRGXR+0cE=";
  };
  installPhase = ''
    mkdir -p $out/phpmyadmin
    cp -r * $out/phpmyadmin
    #ln -s ''${configFile} $out/phpmyadmin/config.inc.php
    chmod 755 -R $out/phpmyadmin
    #chown wwwrun:wwwrun -R $out/phpmyadmin
  '';
}
