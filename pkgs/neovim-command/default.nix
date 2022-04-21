{ pkgs, ... }:


let
  inherit (pkgs.python3Packages) buildPythonPackage;
in

buildPythonPackage rec {
  pname = "neovim-command";
  version = "1.0.0";
  src = ./neovim-command;

  propagatedBuildInputs = with pkgs; [
    python3Packages.pynvim
    python3Packages.setuptools
  ];

  postInstall = ''
    mv -v $out/bin/main.py $out/bin/neovim-command
  '';
}
