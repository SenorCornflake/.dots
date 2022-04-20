{ pkgs, ... }:

let
  inherit (pkgs.python3Packages) buildPythonPackage;
in

buildPythonPackage rec {
  name = "xinput-gui";
  version = "0.3.1";
  propagatedBuildInputs = with pkgs; [
    python3Packages.pygobject3
    gobject-introspection
    python3Packages.setuptools
  ];
  buildInputs = with pkgs; [
    gtk3
    wrapGAppsHook
  ];
  nativeBuildInputs = with pkgs; [
    gobject-introspection
  ];
  src = pkgs.fetchurl {
    url = "https://github.com/ivanfon/xinput-gui/archive/refs/tags/0.3.1.zip";
    sha256 = "0phnldglniil9chvmznhwj91w01yhgkj33hcm8baqjnr6l0zfd1l";
  };
}
