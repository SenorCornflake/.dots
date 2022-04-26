{ pkgs, ... }:

pkgs.picom.overrideAttrs(o: {
  src = pkgs.fetchFromGitHub {
    repo = "picom";
    owner = "ibhagwan";
    rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
    sha256 = "sha256-1hVFBGo4Ieke2T9PqMur1w4D0bz/L3FAvfujY9Zergw=";
  };
})
