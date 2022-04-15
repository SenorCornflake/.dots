{ stdenv, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "extract-xiso";
  version = "build-202112300829";
  src = pkgs.fetchurl {
    url = "https://github.com/XboxDev/extract-xiso/archive/refs/tags/build-202112300829.tar.gz";
    sha256 = "0vf45k95qzx2g32xqgykp33d4c73fnymizvvc3nanxswkdd4dgb9";
  };
  buildInputs = with pkgs; [
    cmake
  ];
  configurePhase = ''
    mkdir build && cd build
    cmake ..
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp extract-xiso $out/bin/extract-xiso
  '';
}
