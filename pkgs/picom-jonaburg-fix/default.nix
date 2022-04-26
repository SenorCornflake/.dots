{ pkgs, ... }:

pkgs.picom.overrideAttrs(o: {
  src = pkgs.fetchFromGitHub {
    repo = "picom";
    owner = "Arian8j2";
    rev = "31d25da22b44f37cbb9be49fe5c239ef8d00df12";
    sha256 = "sha256-1z4bKDoNgmG40y2DKTSSh1NCafrE1rkHkCB3ob8ibm4=";
  };
})
