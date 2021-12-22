{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "php-docs";
  src = pkgs.fetchurl {
    url = "https://www.php.net/distributions/manual/php_manual_en.tar.gz";
    sha256 = "0wk6imxpdk8jx4ahlnc8fm57iympqb079bnydkqn3agh3cf7fi9w";
  };

  installPhase = ''
    mkdir -p $out/php
    cp -r * $out/php
  '';
}
